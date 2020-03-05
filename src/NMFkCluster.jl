import Distances
import Suppressor
import Clustering

"""
Given a vector of classifiers, return a vector where
the highest count is now classifier #1, and the lowest count is
classifer #N

params:
	assignments (Clustering.assignments): a vector containing assignments

returns:
	remapped_assignments: a vector containing "sorted" assignments
"""
function remap2count(assignments)
	# Count how many of each classifier are in the vector
	assignment_count = [(i, count(x->x==i, assignments)) for i in unique(assignments)]

	# Sort the vector by highest -> lowest count
	sort!(assignment_count; by=x->x[2], rev=true)

	# Now, the highest count classifier will be first entry in assignment_count.
	# Create a dictionary that maps "1" => "N", where N is the most populated classifier
	remapper = Dict([(assignment_count[i][1],i) for i in 1:length(unique(assignments))])

	# Finally, map the assignments to the new ordering and return
	mfunc(i) = remapper[i]
	return map(mfunc, assignments)
end

function robustkmeans(X::AbstractMatrix, krange::AbstractRange{Int}, repeats::Int=1000; kw...)
	if krange[1] >= size(X, 2)
		@info("Cannot be computed (min range is greater than or equal to size(X,2); $krange[1] >= $(size(X, 2)))")
		return nothing
	end
	best_totalcost = Inf
	best_mean_silhouettes = 0
	kbest = krange[1]
	local cbest = nothing
	local best_sc = nothing
	for k in krange
		if k >= size(X, 2)
			@info("$k: cannot be computed (k is greater than or equal to size(X,2); $k >= $(size(X, 2)))")
			continue
		end
		c_new, mean_silhouettes, sc = robustkmeans(X, k, repeats; kw...)
		@info("$k: OF: $(c_new.totalcost) Mean Silhouette: $(mean_silhouettes) Worst Silhouette: $(minimum(sc)) Cluster Silhouettes: $(sc)")
		if best_mean_silhouettes < mean_silhouettes
			best_mean_silhouettes = mean_silhouettes
			best_totalcost = c_new.totalcost
			cbest = deepcopy(c_new)
			best_sc = copy(sc)
			kbest = k
		end
	end
	@info("Best $kbest - OF: $best_totalcost Mean Silhouette: $best_mean_silhouettes Worst Silhouette: $(minimum(best_sc)) Silhouettes: $(best_sc)")
	return cbest
end

function robustkmeans(X::AbstractMatrix, k::Int, repeats::Int=1000; maxiter=1000, tol=1e-32, display=:none, distance=Distances.CosineDist(), resultdir::AbstractString=".", casefilename::AbstractString="assignments", save::Bool=false, load::Bool=false)
	if load && casefilename != ""
		filename = joinpath(resultdir, "$casefilename-$k-$repeats.jld")
		if isfile(filename)
			sc = JLD.load(filename, "assignments")
			@info("Robust k-means analysis results are loaded from file $(filename)!")
			return sc
		else
			@warn("File $filename does not exist! Robust k-means analysis will be executed ...")
		end
	end
	local c = nothing
	local best_totalcost = Inf
	local best_mean_silhouettes = Inf
	best_mean_cluster_silhouettes = Vector{Float64}(undef, k)
	for i = 1:repeats
		local c_new
		@Suppressor.suppress begin
			c_new = Clustering.kmeans(X, k; maxiter=maxiter, tol=tol, display=display, distance=distance)
		end
		Xd = Distances.pairwise(Distances.CosineDist(), X; dims=2)
		silhouettes = Clustering.silhouettes(c_new, Xd)
		if i == 1 || c_new.totalcost < best_totalcost
			c = deepcopy(c_new)
			best_totalcost = c_new.totalcost
			best_mean_silhouettes = Statistics.mean(silhouettes)
			for i in unique(c_new.assignments)
				best_mean_cluster_silhouettes[i] = Statistics.mean(silhouettes[c_new.assignments.==i])
			end
		end
	end
	sc = sortclustering(c)
	if save && casefilename != ""
		filename = joinpath(resultdir, "$casefilename-$k-$repeats.jld")
		if !isdir(resultdir)
			recursivemkdir(resultdir; filename=false)
		end
		JLD.save(filename, "assignments", sc)
		@info("Robust k-means analysis results are saved in file $(filename)!")
	end
	return sc
end

function sortclustering(c; rev=true)
	cassignments = similar(c.assignments)
	j = unique(c.assignments)
	# @show j
	# for j = 1:length(j)
	# 	@show sum(c.assignments .== j)
	# end
	for (k, a) in enumerate(j)
		cassignments[c.assignments .== a] .= k
	end
	# @show unique(cassignments)
	# for j = 1:length(j)
	# 	@show sum(cassignments .== j)
	# end
	i = sortperm(c.counts[j]; rev=rev)
	cassignments2 = similar(c.assignments)
	for (k, a) in enumerate(i)
		cassignments2[cassignments .== a] .= k
	end
	# @show unique(cassignments2)
	# for j = 1:length(i)
	# 	@show sum(cassignments2 .== j)
	# end
	r = j[i]
	return Clustering.KmeansResult(c.centers[:,r], cassignments2, c.costs, c.counts[r], c.wcounts[r], c.totalcost, c.iterations, c.converged)
end

function letterassignements(c::Vector)
	t = unique(c)
	nc = length(c)
	nt = length(t)
	if nt < 31
		types = collect(range('A'; length=nt))
		cassignments = Vector{Char}(undef, nc)
	else
		types = ["T$i" for i=1:nt]
		cassignments = Vector{String}(undef, nc)
	end
	for a in t
		cassignments[c .== a] .= types[a]
	end
	return cassignments
end

function finduniquesignals(X::Matrix)
	k = size(X, 1)
	@assert k == size(X, 2)
	smap = zeros(Int64, k)
	Xc = copy(X)
	failed = false
	while any(smap .== 0)
		if all(Xc .== 0.)
			@warn "Could not find a solution"
			failed = true
			break
		end
		rc = findmax(Xc)[2]
		Xc[rc] = 0.
		if smap[rc[1]] == 0 && !any(smap .== rc[2])
			smap[rc[1]] = rc[2]
		end
	end
	local o = 0
	if !failed
		for i = 1:k
			o += X[i,smap[i]]
		end
	end
	return o, smap
end

function finduniquesignalsbest(X::Matrix)
	o, smap = finduniquesignals(X)
	k = size(X, 1)
	obest = o
	smapbest = smap
	for i = 1:k
		Xc = copy(X)
		Xc[i, smap[i]] = 0.
		o, smap = finduniquesignals(Xc)
		if o > obest
			obest = o
			smapbest = smap
		end
	end
	return smapbest
end

function clustersolutions(factors::Vector{Matrix}, clusterWmatrix::Bool=false)
	if !clusterWmatrix
		factors = [permutedims(f) for f in factors]
	end
	# invariant: we can now assume that our matrices are n x k
	numFactors = length(factors)
	numTrials = numFactors
	r, k = size(factors[1])
	for w in factors
		@assert size(w) == (r, k)
	end
	# fix zero case
	needZeroFix = false
	for i in 1:numFactors
		factor = factors[i]
		if minimum(sum(factor; dims=1)) == 0  # if we have a zero column
			needZeroFix = true
			break
		end
	end
	if needZeroFix
		biasRow = permutedims(ones(k))
		for i in 1:numFactors
			factors[i] = vcat(factors[i], biasRow)
		end
	end
	# invariant: at this point, no factor has a column with all zeros

	centSeeds = factors[1]
	# when we label a factor column, we are going to keep a sum
	newClusterCenters = factors[1]
	# clusterLabels[a, b] = c --> factors[b][:, a] belongs to cluster c
	clusterLabels = zeros(Int, k, numTrials)
	# note: all clusterLabels should be in [1, k] upon return

	# by definition, the columns of the first solution belong to their own cluster.
	clusterLabels[:, 1] = [i for i in 1:k]

	clusterDistances = Matrix{Float64}(undef, k, k)
	for trial in 2:numTrials
		W = factors[trial]
		# clusterDistances[a, b] = c --> dist(W[:,a], centSeeds[:,b]) = c
		for centroidIdx in 1:k
			centroid = centSeeds[:, centroidIdx]
			for factorColIdx in 1:k
				clusterDistances[factorColIdx, centroidIdx] = Distances.cosine_dist(W[:, factorColIdx], centroid)
			end
		end
		clusterDistances[isnan.(clusterDistances)] .= 0
		while minimum(clusterDistances) < Inf
			# get the row and column of the smallest distance
			selectFactorCol, selectCentIdx = Tuple(CartesianIndices(clusterDistances)[argmin(clusterDistances)])
			# save that col in trial belongs to centroid's cluster
			# println("Assigned: Trial: $trial, Factor: $selectFactorCol, Centroid: $selectCentIdx")
			clusterLabels[selectFactorCol, trial] = selectCentIdx
			# this factor cannot belong to other centSeeds
			clusterDistances[selectFactorCol, :] .+= Inf
			# this cluster cannot collect more factor columns
			clusterDistances[:, selectCentIdx] .+= Inf
			newClusterCenters[:, selectCentIdx] .+= W[:, selectFactorCol]
		end
	end
	while minimum(clusterLabels) == 0
		idx, trial = Tuple(CartesianIndices(clusterLabels)[argmin(clusterLabels)])
		if sum(clusterLabels[:, trial]) == 0
			@warn("Solution $trial was not assigned to any of the cluster!")
			clusterLabels[:, trial] = [i for i in 1:k]
		else
			@warn("Parameter $idx in solution $trial was not assigned a cluster!")
			clusterLabels[idx, trial] = idx
		end
	end
	if minimum(clusterLabels) <= 0
		@warn("Minimum assignments should be greater than 1: $(minimum(clusterLabels))")
	end
	if maximum(clusterLabels) > k
		@warn("Maximum assignments should be less than $k: $(maximum(clusterLabels))")
	end
	for i in 1:k
		for j in 1:numTrials
			l = length(findall((in)(i), clusterLabels[:, j]))
			if l != 1
				@warn("Cluster $i does not appear only once in column $j; it appears $l times!")
			end
		end
	end

	newClusterCenters ./= numTrials
	if !clusterWmatrix
		factors = [permutedims(f) for f in factors]
	end
		return clusterLabels, permutedims(newClusterCenters)
end

"Cluster NMFk solutions"
function clustersolutions_old(W::Vector, clusterWmatrix::Bool=false)
	nNMF = length(W)
	nc, nr = size(W[1])
	nk = clusterWmatrix ? nr : nc

	centroids = W[1]
	idx = Array{Int}(undef, nk, nNMF)

	for clusterIt = 1:nNMF
		for globalIterID = 1:nNMF
			processesTaken = falses(nk)
			centroidsTaken = falses(nk)
			for currentProcessID = 1:nk
				distMatrix = ones(nk, nk) + Inf
				for processID = 1:nk
					if !processesTaken[processID]
						for centroidID = 1:nk
							if !centroidsTaken[centroidID]
								if clusterWmatrix
									distMatrix[processID, centroidID] = Distances.cosine_dist(W[globalIterID][:, processID], centroids[:, centroidID])
								else
									distMatrix[processID, centroidID] = Distances.cosine_dist(W[globalIterID][processID, :], centroids[centroidID, :])
								end
							end
						end
					end
				end
				minProcess, minCentroid = Tuple(CartesianIndices(size(distMatrix))[argmin(distMatrix)])
				processesTaken[minProcess] = true
				centroidsTaken[minCentroid] = true
				idx[minProcess, globalIterID] = minCentroid
			end
		end
		centroids = zeros(size(W[1]))
		for centroidID = 1:nk
			for globalIterID = 1:nNMF
				if clusterWmatrix
					centroids[:, centroidID] += W[globalIterID][:, findall((in)(centroidID), idx[:, globalIterID])]
				else
					centroids[centroidID:centroidID, :] += W[globalIterID][findall((in)(centroidID), idx[:, globalIterID]), :]
				end
			end
		end
		centroids ./= nNMF
	end
	return idx, permutedims(centroids)
end

function clustersolutions_old(W::Matrix, nNMF::Integer)
	nP, nT = size(W) # number of observations (components/transients), number of total number of signals to cluster
	nk = convert(Int, nT / nNMF)

	centroids = W[:, 1:nk]
	idx = Array{Int}(undef, nk, nNMF)

	for clusterIt = 1:nNMF
		for globalIterID = 1:nNMF
			processesTaken = falses(nk)
			centroidsTaken = falses(nk)
			for currentProcessID = 1:nk
				distMatrix = ones(nk, nk) + Inf
				for processID = 1:nk
					if !processesTaken[processID]
						for centroidID = 1:nk
							if !centroidsTaken[centroidID]
								distMatrix[processID, centroidID] = Distances.cosine_dist(W[:,processID + (globalIterID - 1) * nk], centroids[:,centroidID])
							end
						end
					end
				end
				minProcess, minCentroid = Tuple(CartesianIndices(size(distMatrix))[argmin(distMatrix)])
				processesTaken[minProcess] = true
				centroidsTaken[minCentroid] = true
				idx[minProcess, globalIterID] = minCentroid
			end
		end
		centroids = zeros(nP, nk)
		for centroidID = 1:nk
			for globalIterID = 1:nNMF
				centroids[:, centroidID] += W[:, findall((in)(centroidID), idx[:, globalIterID]) + (globalIterID - 1) * nk]
			end
		end
		centroids ./= nNMF
	end
	return idx, permutedims(centroids)
end

module NMFk

import NMF
import Distances
import Clustering
import JuMP
import Ipopt
import JLD
import ReusableFunctions

const nmfkdir = splitdir(splitdir(Base.source_path())[1])[1]

restart = false

include("NMFkCluster.jl")
include("NMFkGeoChem.jl")
include("NMFkMixMatch.jl")
include("NMFkIpopt.jl")
include("NMFkMatrix.jl")
include("NMFkExecute.jl")
include("NMFkRestart.jl")
include("NMFkFinalize.jl")
include("NMFkLoad.jl")
include("NMFkBootstrap.jl")
include("NMFkSparse.jl")
include("NMFkMultiplicative.jl")
include("NMFkDisplay.jl")
include("NMFkCapture.jl")

end
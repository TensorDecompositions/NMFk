import Gadfly
import Colors

function colormap(n::Integer)
	colormap(colors[1:n])
end

function colormap(colors::AbstractVector{String})
	c = []
	for i = 1:length(colors)
		push!(c, parse(Colors.Colorant, colors[i]))
	end
	cm = [Gadfly.Scale.lab_gradient(c...)]
end

colors = ["red", "blue", "green", "orange", "magenta", "cyan", "brown", "pink", "lime", "navy", "maroon", "yellow", "olive", "springgreen", "teal", "coral", "#e6beff", "beige", "purple", "#4B6F44", "#9F4576"]
ncolors = length(colors)

# r = reshape(repeat(collect(1/100:1/100:1), inner=100), (100,100))
# NTFk.plotmatrix(r; colormap=NTFk.colormap_hsv2);

rbwlong_ncar = [
0.250980 0.000000 0.276078;
0.250980 0.000000 0.326275;
0.250980 0.000000 0.376471;
0.250980 0.000000 0.426667;
0.250980 0.000000 0.476863;
0.250980 0.000000 0.527059;
0.250980 0.000000 0.577255;
0.250980 0.000000 0.627451;
0.250980 0.000000 0.677647;
0.250980 0.000000 0.727843;
0.238431 0.012549 0.765294;
0.213333 0.037647 0.790000;
0.188235 0.062745 0.814706;
0.163137 0.087843 0.839412;
0.138039 0.112941 0.864118;
0.112941 0.138039 0.888824;
0.087843 0.163137 0.913529;
0.062745 0.188235 0.938235;
0.037647 0.213333 0.962941;
0.012549 0.238431 0.987647;
0.000000 0.263529 1.000000;
0.000000 0.288627 1.000000;
0.000000 0.313725 1.000000;
0.000000 0.338824 1.000000;
0.000000 0.363922 1.000000;
0.000000 0.389020 1.000000;
0.000000 0.414118 1.000000;
0.000000 0.439216 1.000000;
0.000000 0.464314 1.000000;
0.000000 0.489412 1.000000;
0.000000 0.508235 1.000000;
0.000000 0.520784 1.000000;
0.000000 0.533333 1.000000;
0.000000 0.545882 1.000000;
0.000000 0.558431 1.000000;
0.000000 0.570980 1.000000;
0.000000 0.583529 1.000000;
0.000000 0.596078 1.000000;
0.000000 0.608627 1.000000;
0.000000 0.621176 1.000000;
0.012549 0.633725 1.000000;
0.037647 0.646275 1.000000;
0.062745 0.658824 1.000000;
0.087843 0.671373 1.000000;
0.112941 0.683922 1.000000;
0.138039 0.696471 1.000000;
0.163137 0.709020 1.000000;
0.188235 0.721569 1.000000;
0.213333 0.734118 1.000000;
0.238431 0.746667 1.000000;
0.250980 0.759216 1.000000;
0.250980 0.771765 1.000000;
0.250980 0.784314 1.000000;
0.250980 0.796863 1.000000;
0.250980 0.809412 1.000000;
0.250980 0.821961 1.000000;
0.250980 0.834510 1.000000;
0.250980 0.847059 1.000000;
0.250980 0.859608 1.000000;
0.250980 0.872157 1.000000;
0.250980 0.884510 1.000000;
0.250980 0.896667 1.000000;
0.250980 0.908824 1.000000;
0.250980 0.920980 1.000000;
0.250980 0.933137 1.000000;
0.250980 0.945294 1.000000;
0.250980 0.957451 1.000000;
0.250980 0.969608 1.000000;
0.250980 0.981765 1.000000;
0.250980 0.993922 1.000000;
0.250980 1.000000 0.987647;
0.250980 1.000000 0.962941;
0.250980 1.000000 0.938235;
0.250980 1.000000 0.913529;
0.250980 1.000000 0.888824;
0.250980 1.000000 0.864118;
0.250980 1.000000 0.839412;
0.250980 1.000000 0.814706;
0.250980 1.000000 0.790000;
0.250980 1.000000 0.765294;
0.250980 1.000000 0.727843;
0.250980 1.000000 0.677647;
0.250980 1.000000 0.627451;
0.250980 1.000000 0.577255;
0.250980 1.000000 0.527059;
0.250980 1.000000 0.476863;
0.250980 1.000000 0.426667;
0.250980 1.000000 0.376471;
0.250980 1.000000 0.326275;
0.250980 1.000000 0.276078;
0.263529 1.000000 0.250980;
0.288627 1.000000 0.250980;
0.313725 1.000000 0.250980;
0.338824 1.000000 0.250980;
0.363922 1.000000 0.250980;
0.389020 1.000000 0.250980;
0.414118 1.000000 0.250980;
0.439216 1.000000 0.250980;
0.464314 1.000000 0.250980;
0.489412 1.000000 0.250980;
0.514510 1.000000 0.250980;
0.539608 1.000000 0.250980;
0.564706 1.000000 0.250980;
0.589804 1.000000 0.250980;
0.614902 1.000000 0.250980;
0.640000 1.000000 0.250980;
0.665098 1.000000 0.250980;
0.690196 1.000000 0.250980;
0.715294 1.000000 0.250980;
0.740392 1.000000 0.250980;
0.765294 1.000000 0.250980;
0.790000 1.000000 0.250980;
0.814706 1.000000 0.250980;
0.839412 1.000000 0.250980;
0.864118 1.000000 0.250980;
0.888824 1.000000 0.250980;
0.913529 1.000000 0.250980;
0.938235 1.000000 0.250980;
0.962941 1.000000 0.250980;
0.987647 1.000000 0.250980;
1.000000 0.993922 0.250980;
1.000000 0.981765 0.250980;
1.000000 0.969608 0.250980;
1.000000 0.957451 0.250980;
1.000000 0.945294 0.250980;
1.000000 0.933137 0.250980;
1.000000 0.920980 0.250980;
1.000000 0.908824 0.250980;
1.000000 0.896667 0.250980;
1.000000 0.884510 0.250980;
1.000000 0.865882 0.250980;
1.000000 0.840784 0.250980;
1.000000 0.815686 0.250980;
1.000000 0.790588 0.250980;
1.000000 0.765490 0.250980;
1.000000 0.740392 0.250980;
1.000000 0.715294 0.250980;
1.000000 0.690196 0.250980;
1.000000 0.665098 0.250980;
1.000000 0.640000 0.250980;
1.000000 0.614902 0.250980;
1.000000 0.589804 0.250980;
1.000000 0.564706 0.250980;
1.000000 0.539608 0.250980;
1.000000 0.514510 0.250980;
1.000000 0.489412 0.250980;
1.000000 0.464314 0.250980;
1.000000 0.439216 0.250980;
1.000000 0.414118 0.250980;
1.000000 0.389020 0.250980;
1.000000 0.363922 0.250980;
1.000000 0.338824 0.250980;
1.000000 0.313725 0.250980;
1.000000 0.288627 0.250980;
1.000000 0.263529 0.250980;
1.000000 0.238431 0.250980;
1.000000 0.213333 0.250980;
1.000000 0.188235 0.250980;
1.000000 0.163137 0.250980;
1.000000 0.138039 0.250980;
1.000000 0.138039 0.276078;
1.000000 0.163137 0.326275;
1.000000 0.188235 0.376471;
1.000000 0.213333 0.426667;
1.000000 0.238431 0.476863;
1.000000 0.263529 0.527059;
1.000000 0.288627 0.577255;
1.000000 0.313725 0.627451;
1.000000 0.338824 0.677647;
1.000000 0.363922 0.727843;
1.000000 0.389020 0.765294;
1.000000 0.414118 0.790000;
1.000000 0.439216 0.814706;
1.000000 0.464314 0.839412;
1.000000 0.489412 0.864118;
1.000000 0.514510 0.888824;
1.000000 0.539608 0.913529;
1.000000 0.564706 0.938235;
1.000000 0.589804 0.962941;
1.000000 0.614902 0.987647;
1.000000 0.640000 0.994118;
1.000000 0.665098 0.982353;
1.000000 0.690196 0.970588;
1.000000 0.715294 0.958824;
1.000000 0.740392 0.947059;
1.000000 0.765490 0.935294;
1.000000 0.790588 0.923529;
1.000000 0.815686 0.911765;
1.000000 0.840784 0.900000;
1.000000 0.865882 0.888235;
1.000000 0.883343 1.000000;
1.000000 0.895623 1.000000;
1.000000 0.907903 1.000000;
1.000000 0.920182 1.000000;
1.000000 0.932462 1.000000;
1.000000 0.944742 1.000000;
1.000000 0.957021 1.000000;
1.000000 0.969301 1.000000;
1.000000 0.981581 1.000000;
1.000000 0.993860 1.000000;
];


rgb_ncar = [
	 # 4   0   3;
	 # 9   0   7;
	# 13   0  10;
	18   0  14;
	22   0  19;
	27   0  23;
	31   0  28;
	36   0  32;
	40   0  38;
	45   0  43;
	50   0  48;
	58   0  59;
	64   0  68;
	68   0  72;
	69   0  77;
	72   0  81;
	74   0  86;
	77   0  91;
	79   0  95;
	80   0 100;
	82   0 104;
	83   0 109;
	84   0 118;
	86   0 122;
	88   0 132;
	86   0 136;
	87   0 141;
	87   0 145;
	87   0 150;
	85   0 154;
	84   0 159;
	84   0 163;
	84   0 168;
	79   0 177;
	78   0 182;
	77   0 186;
	76   0 191;
	70   0 200;
	68   0 204;
	66   0 209;
	60   0 214;
	58   0 218;
	55   0 223;
	46   0 232;
	43   0 236;
	40   0 241;
	36   0 245;
	33   0 250;
	25   0 255;
	16   0 255;
	12   0 255;
	 4   0 255;
	 0   0 255;
	 0   4 255;
	 0  16 255;
	 0  21 255;
	 0  25 255;
	 0  29 255;
	 0  38 255;
	 0  42 255;
	 0  46 255;
	 0  51 255;
	 0  63 255;
	 0  67 255;
	 0  72 255;
	 0  84 255;
	 0  89 255;
	 0  93 255;
	 0  97 255;
	 0 106 255;
	 0 110 255;
	 0 114 255;
	 0 119 255;
	 0 127 255;
	 0 135 255;
	 0 140 255;
	 0 152 255;
	 0 157 255;
	 0 161 255;
	 0 165 255;
	 0 174 255;
	 0 178 255;
	 0 182 255;
	 0 187 255;
	 0 195 255;
	 0 199 255;
	 0 216 255;
	 0 220 255;
	 0 225 255;
	 0 229 255;
	 0 233 255;
	 0 242 255;
	 0 246 255;
	 0 250 255;
	 0 255 255;
	 0 255 246;
	 0 255 242;
	 0 255 238;
	 0 255 225;
	 0 255 216;
	 0 255 212;
	 0 255 203;
	 0 255 199;
	 0 255 195;
	 0 255 191;
	 0 255 187;
	 0 255 178;
	 0 255 174;
	 0 255 170;
	 0 255 157;
	 0 255 152;
	 0 255 144;
	 0 255 135;
	 0 255 131;
	 0 255 127;
	 0 255 123;
	 0 255 114;
	 0 255 110;
	 0 255 106;
	 0 255 102;
	 0 255  89;
	 0 255  84;
	 0 255  80;
	 0 255  76;
	 0 255  63;
	 0 255  59;
	 0 255  55;
	 0 255  46;
	 0 255  42;
	 0 255  38;
	 0 255  25;
	 0 255  21;
	 0 255  16;
	 0 255  12;
	 0 255   8;
	 0 255   0;
	 8 255   0;
	12 255   0;
	21 255   0;
	25 255   0;
	29 255   0;
	42 255   0;
	46 255   0;
	51 255   0;
	55 255   0;
	63 255   0;
	67 255   0;
	72 255   0;
	76 255   0;
	89 255   0;
	93 255   0;
	97 255   0;
 110 255   0;
 114 255   0;
 119 255   0;
 123 255   0;
 131 255   0;
 135 255   0;
 140 255   0;
 144 255   0;
 153 255   0;
 161 255   0;
 165 255   0;
 178 255   0;
 182 255   0;
 187 255   0;
 191 255   0;
 199 255   0;
 203 255   0;
 208 255   0;
 212 255   0;
 221 255   0;
 225 255   0;
 242 255   0;
 246 255   0;
 250 255   0;
 255 255   0;
 255 250   0;
 255 242   0;
 255 238   0;
 255 233   0;
 255 229   0;
 255 221   0;
 255 216   0;
 255 212   0;
 255 199   0;
 255 191   0;
 255 187   0;
 255 178   0;
 255 174   0;
 255 170   0;
 255 165   0;
 255 161   0;
 255 153   0;
 255 148   0;
 255 144   0;
 255 131   0;
 255 127   0;
 255 119   0;
 255 110   0;
 255 106   0;
 255 102   0;
 255  97   0;
 255  89   0;
 255  85   0;
 255  80   0;
 255  76   0;
 255  63   0;
 255  59   0;
 255  55   0;
 255  51   0;
 255  38   0;
 255  34   0;
 255  29   0;
 255  21   0;
 255  17   0;
 255  12   0;
 255   0   0;
 255   0   0;
 255   0   0;
 255   0   0;
 255   0   0;
 255   0   0;
 255   0   0;
 255   0   0;
 255   0   0;
 255   0   0;
 255   0   0;
 255   0   0;
 255   0   0;
 255   0   0;
 255   0   0;
 255   0   0;
 255   0   0;
 255   0   0];

gist_ncar = [0  0 128;
	 0   9 115;
	 0  19 103;
	 0  28  91;
	 0  38  79;
	 0  47  66;
	 0  57  54;
	 0  66  42;
	 0  76  30;
	 0  85  18;
	 0  95   5;
	 0  94  12;
	 0  85  37;
	 0  75  61;
	 0  66  85;
	 0  56 110;
	 0  47 134;
	 0  37 158;
	 0  28 183;
	 0  18 207;
	 0   9 231;
	 0   0 255;
	 0  19 255;
	 0  37 255;
	 0  55 255;
	 0  73 255;
	 0  92 255;
	 0 110 255;
	 0 128 255;
	 0 146 255;
	 0 165 255;
	 0 183 255;
	 0 194 255;
	 0 200 255;
	 0 206 255;
	 0 212 255;
	 0 218 255;
	 0 225 255;
	 0 231 255;
	 0 237 255;
	 0 243 255;
	 0 249 255;
	 0 254 253;
	 0 254 244;
	 0 253 234;
	 0 253 225;
	 0 253 215;
	 0 252 205;
	 0 252 196;
	 0 251 186;
	 0 251 176;
	 0 250 167;
	 0 250 157;
	 0 250 144;
	 0 250 130;
	 0 251 115;
	 0 251 100;
	 0 252  85;
	 0 252  71;
	 0 253  56;
	 0 253  41;
	 0 254  27;
	 0 254  12;
	 1 254   0;
	11 249   0;
	21 244   0;
	30 239   0;
	40 235   0;
	50 230   0;
	59 225   0;
	69 220   0;
	79 216   0;
	89 211   0;
	98 206   0;
 103 208   0;
 106 213   0;
 108 217   0;
 110 222   0;
 113 227   0;
 115 232   0;
 117 236   0;
 120 241   0;
 122 246   0;
 125 251   0;
 128 255   1;
 134 255   7;
 140 255  13;
 146 255  19;
 153 255  24;
 159 255  30;
 165 255  36;
 171 255  42;
 177 255  48;
 184 255  54;
 190 255  60;
 196 255  57;
 202 255  51;
 208 255  45;
 214 255  39;
 220 255  33;
 226 255  28;
 232 255  22;
 238 255  16;
 244 255  10;
 250 255   4;
 255 253   0;
 255 250   0;
 255 246   0;
 255 242   0;
 255 238   0;
 255 234   0;
 255 231   0;
 255 227   0;
 255 223   0;
 255 219   0;
 255 215   0;
 255 212   1;
 255 209   2;
 255 207   3;
 255 204   5;
 255 201   6;
 255 198   8;
 255 195   9;
 255 192  11;
 255 189  12;
 255 186  14;
 255 181  14;
 255 170  13;
 255 159  11;
 255 148  10;
 255 137   8;
 255 126   7;
 255 115   5;
 255 103   4;
 255  92   3;
 255  81   1;
 255  70   0;
 255  63   0;
 255  56   0;
 255  50   0;
 255  43   0;
 255  37   0;
 255  30   0;
 255  23   0;
 255  17   0;
 255  10   0;
 255   4   0;
 255   0   8;
 255   0  33;
 255   0  57;
 255   0  82;
 255   0 106;
 255   0 130;
 255   0 155;
 255   0 179;
 255   0 203;
 255   0 228;
 255   0 252;
 246   4 255;
 236   8 255;
 227  13 255;
 217  17 255;
 208  22 255;
 198  27 255;
 189  31 255;
 179  36 255;
 170  40 255;
 160  45 255;
 158  51 254;
 166  59 252;
 174  66 251;
 182  74 249;
 190  82 247;
 197  90 246;
 205  98 244;
 213 106 242;
 221 113 241;
 229 121 239;
 237 129 238;
 238 135 238;
 239 141 239;
 239 146 239;
 240 152 240;
 241 158 241;
 241 164 241;
 242 169 242;
 243 175 243;
 243 181 243;
 244 186 244;
 245 192 245;
 246 199 246;
 247 205 247;
 248 211 248;
 249 217 249;
 250 223 250;
 251 230 251;
 252 236 252;
 253 242 253;
 254 248 254;
 255 255 255];

colormap_rbwlong = [Gadfly.Scale.lab_gradient([Colors.RGB{Colors.N0f8}(rbwlong_ncar[i, :]...) for i=1:size(rbwlong_ncar, 1)]...)]
colormap_ncar = [Gadfly.Scale.lab_gradient([Colors.RGB{Colors.N0f8}(rgb_ncar[i, :]./255...) for i=1:size(rgb_ncar, 1)]...)]
colormap_gist = [Gadfly.Scale.lab_gradient([Colors.RGB{Colors.N0f8}(gist_ncar[i, :]./255...) for i=1:size(gist_ncar, 1)]...)]
colormap_hsv2 = [Gadfly.Scale.lab_gradient(Colors.RGB{Colors.N0f8}(42/255, 28/255, 14/255), parse(Colors.Colorant, "coral"), parse(Colors.Colorant, "darkmagenta"), parse(Colors.Colorant, "peachpuff"), parse(Colors.Colorant, "darkblue"), parse(Colors.Colorant, "cyan"), parse(Colors.Colorant, "green"), parse(Colors.Colorant, "yellow"), parse(Colors.Colorant, "red"))]
colormap_hsv = [Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "magenta"), parse(Colors.Colorant, "peachpuff"), parse(Colors.Colorant, "blue"), parse(Colors.Colorant, "cyan"), parse(Colors.Colorant, "green"), parse(Colors.Colorant, "yellow"), parse(Colors.Colorant, "red"))]
colormap_rbw2 = [Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "blue"), parse(Colors.Colorant, "cyan"), parse(Colors.Colorant, "green"), parse(Colors.Colorant, "yellow"), parse(Colors.Colorant, "red"), parse(Colors.Colorant, "darkmagenta"))]
colormap_rbw = [Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "blue"), parse(Colors.Colorant, "cyan"), parse(Colors.Colorant, "green"), parse(Colors.Colorant, "yellow"), parse(Colors.Colorant, "red"))]
colormap_gyr = [Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "green"), parse(Colors.Colorant, "yellow"), parse(Colors.Colorant, "red"))]
colormap_gy = [Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "green"), parse(Colors.Colorant, "yellow"))]
colormap_ry = [Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "red"), parse(Colors.Colorant, "yellow"))]
colormap_by = [Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "blue"), parse(Colors.Colorant, "yellow"))]
colormap_g = [Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "lightgreen"), parse(Colors.Colorant, "green"))]
colormap_r = [Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "pink"), parse(Colors.Colorant, "red"))]
colormap_b = [Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "lightblue"), parse(Colors.Colorant, "blue"))]
colormap_array_rgb = [colormap_r, colormap_b, colormap_g]
colormap_wb = [Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "white"), parse(Colors.Colorant, "black"))]
# colormap_g_ = [Gadfly.Scale.lab_gradient(Colors.RGBA{Colors.N0f8}(0,1,0,0), Colors.RGBA{Colors.N0f8}(0,1,0,1))]
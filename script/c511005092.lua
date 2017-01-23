--Sealed Duel
-- - Works with Single Duel

local function getID()
	local str=string.match(debug.getinfo(2,'S')['source'],"c%d+%.lua")
	str=string.sub(str,1,string.len(str)-4)
	local scard=_G[str]
	local s_id=tonumber(string.sub(str,2))
	return scard,s_id
end

local scard,s_id=getID()

--before anything
if not scard.rc_ovr then
	scard.rc_ovr=true
	local c_getrace=Card.GetRace
	Card.GetRace=function(c)
		if c:IsType(TYPE_MONSTER) then return 0xffffff end
		return c_getrace(c)
	end
	local c_getorigrace=Card.GetOriginalRace
	Card.GetOriginalRace=function(c)
		if c:IsType(TYPE_MONSTER) then return 0xffffff end
		return c_getorigrace(c)
	end
	local c_getprevraceonfield=Card.GetPreviousRaceOnField
	Card.GetPreviousRaceOnField=function(c)
		if bit.band(c:GetPreviousTypeOnField(),TYPE_MONSTER)~=0 then return 0xffffff end
		return c_getprevraceonfield(c)
	end
	local c_israce=Card.IsRace
	Card.IsRace=function(c,r)
		if c:IsType(TYPE_MONSTER) then return true end
		return c_israce(c,r)
	end
	local d_createtoken=Duel.CreateToken
	Duel.CreateToken=function(...)
		local args={select(1,...)}
		local c=d_createtoken(table.unpack(args))
		c:RegisterFlagEffect(s_id,0,0,0)
		return c
	end
end

function scard.initial_effect(c)
	if scard.regok then return end
	scard.regok=true
	--Pre-draw
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCountLimit(1)
	e1:SetOperation(scard.op)
	Duel.RegisterEffect(e1,0)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e2:SetCountLimit(1)
	e2:SetCondition(scard.nt_cd)
	e2:SetOperation(scard.nt_op)
	Duel.RegisterEffect(e2,0)
end

--define pack
--pack[1]=BP01, [2]=BP02, [3]=BPW2, [4]=BP03
--[1]=rare, [2/3/4]=common, [5]=foil
local pack={}
	pack[1]={}
	pack[1][1]={
		78010363,34124316,77585513,79575620,89111398,61370518,40737112,25551951,4929256,88753985,83104731,
		12538374,85520851,44330098,73125233,79473793,17559367,9748752,59575539,98777036,10000000,5556499,
		10802915,84013237,10002346,47506081,69610924,68597372,31386180,94119480,71594310,12580477,72302403,
		55144522,18144506,79571449,4031928,19613556,45986603,70828912,68005187,73915051,56747793,31036355,
		44947065,98645731,41420027,44095762,97077563,83555666,53582587,26905245,82732705,49010598,77538567
	}
	pack[1][2]={
		61831093,93920745,1347977,74131780,45141844,71413901,48343627,21502796,91133740,66788016,79759861,
		40619825,5318639,64047146,19230407,7165085,14087893,71453557,34236961,61127349,24874630,56460688,
		98045062,43040603,30683373,6178850,25789292,83584898,27243130,6430659,73178098,37390589,60082869,
		59744639,59344077,62279055,29267084,98239899,38411870,37576645,54704216,38275183,36261276,94192409,
		66518841,15552258,73729209,46502013,24673894,50078509,79161790,21636650,53656677,87106146,72022087,
		11091375
	}
	pack[1][3]={
		49881766,79182538,13179332,35052053,69247929,78193831,78658564,40133511,88472456,78636495,53982768,
		49681811,18036057,2134346,63749102,53839837,42386471,83986578,40659562,46363422,51945556,70074904,
		51838385,14778250,90810762,16956455,70095154,59023523,85306040,78700060,77252217,85087012,93151201,
		20546916,39303359,61802346,78651105,51196174,37955049,60953118,83269557,17573739,70050374,44223284,
		23927545,59042331,12235475,95637655,41224658,7025445,4694209,94215860,62476815,51254277,12299841,
		12076263,33225925,41098335,53540729,13039848,28933734
	}
	pack[1][4]={
		33508719,46657337,26302522,65240384,45894482,52860176,43586926,21593977,47025270,16268841,1434352,
		3510565,2671330,11448373,16226786,88975532,87621407,18325492,71218746,29216198,83982270,33695750,
		31034919,30312361,3657444,14089428,7736719,14506878,15658249,95360850,97021916,45620686,47217354,
		66288028,40225398,97385276,57421866,55099248,19665973,53162898,89567993,68473226,14785765,15394083,
		86952477,26082117,25259669
	}
	pack[1][5]={}
	for _,v in ipairs(pack[1][1]) do table.insert(pack[1][5],v) end
	for _,v in ipairs(pack[1][2]) do table.insert(pack[1][5],v) end
	for _,v in ipairs(pack[1][3]) do table.insert(pack[1][5],v) end
	for _,v in ipairs(pack[1][4]) do table.insert(pack[1][5],v) end
	pack[2]={}
	pack[2][1]={
		6631034,31560081,34124316,66362965,79575620,7572887,40737112,68007326,78636495,70074904,83104731,
		15894048,85520851,81919143,58554959,61538782,3657444,40921744,33655493,83269557,49879995,59575539,
		5645210,8483333,78651105,79473793,19028307,85028288,55690251,97940434,55758589,45812361,36088082,
		21954587,10532969,61231400,83764718,55144522,70828912,79571449,48712195,98645731,33904024,81000306,
		97077563,37576645,42671151,60080151,6691855
	}
	pack[2][2]={
		11091375,69247929,43096270,93013676,78658564,31709826,88240808,40133511,45894482,88472456,8131171,
		18036057,43586926,47025270,90790253,16268841,2671330,22609617,4041838,88975532,15960641,65240384,
		42386471,16956455,18325492,44729197,71218746,70095154,85306040,63749102,55424270,12538374,99861526,
		85087012,48115277,93187568,18430390,4906301,66337215,39303359,64262809,26376390,78700060,13893596,
		95360850,97021916,14778250,33420078,96938777,20546916,61802346,33695750,15341821,66288028,40225398
	}
	pack[2][3]={
		59042331,4694209,96872283,19665973,42280216,64926005,7025445,58324930,41098335,15394083,84914462,
		40619741,14785765,97896503,62476815,56223084,2584136,65367484,25206027,52823314,1281505,38679204,
		74064212,86039057,12423762,66499018,64892035,33911264,19700943,82593786,18988391,42969214,66200210,
		52097679,40619825,99597615,70046172,64047146,73915051,14087893,58577036,71453557,61127349,34016756,
		32022366,98045062,82828051,55713623,12923641,58775978,80921533,24874630,60399954,6178850
	}
	pack[2][4]={
		67196946,25789292,91580102,27863269,73048641,98867329,19578592,27243130,22346472,73178098,17418744,
		96864811,77622396,12607053,22359980,68540058,57882509,93382620,59744639,83133491,21597117,28649820,
		43250041,66742250,66526672,36361633,78211862,96008713,12117532,13955608,30643162,60306104,86871614,
		60406591,26905245,79852326,34815282,97151365,71272951,37390589,66518841,80987696,15552258,97168905,
		73729209,53656677,87106146,21636650,6799227,3129635,49514333,86778566,44046281,78474168
	}
	pack[2][5]={
		10000000,10000010,10000020
	}
	for _,v in ipairs(pack[2][1]) do table.insert(pack[2][5],v) end
	for _,v in ipairs(pack[2][2]) do table.insert(pack[2][5],v) end
	for _,v in ipairs(pack[2][3]) do table.insert(pack[2][5],v) end
	for _,v in ipairs(pack[2][4]) do table.insert(pack[2][5],v) end
	pack[3]={}
	pack[3][1]={
		13945283,62340868,51534754,25773409,59380081,52323207,53828396,76763417,2158562,50287060,99747800,
		22624373,18489208,68722455,11613567,98954375,20351153,72328962,81275309,2137678,43359262,95905259,
		5244497,49374988,40921545,83274244,30811116,79759861,56830749,22046459,70231910,56460688,47453433,
		25774450,98847704,59560625,62325062,77538567,42793609,89792713,11741041,75987257,22869904
	}
	pack[3][2]={
		77542832,16768387,39751093,87523462,39978267,39168895,56647086,39507162,95701283,54749427,23303072,
		41753322,88650530,84932271,88494899,96146814,69529567,45801022
	}
	pack[3][3]={
		6903857,43332022,98649372,47349310,20193924,56410040,79972330,8814959,9861795,8649148,61132951,
		44682448,80208158,5284653,4058065,67922702,4417407,54635862
	}
	pack[3][4]={
		6930746,83225447,65169794,34664411,43422537,37534148,52497105,70344351,38411870,90669991,74458486,
		31000575,18271561,85352446,49204190,73632127,71098407,63630268,94156050
	}
	pack[3][5]={
		6614221,86585274,21249921,80117527,38296564
	}
	pack[4]={}
	pack[4][1]={
		42364374,71413901,82108372,39168895,78636495,42386471,16956455,85306040,89222931,85087012,18430390,
		61802346,39303359,54040221,52319752,14089428,76203291,75081613,96235275,41113025,6061630,92826944,
		84847656,74976215,69695704,45041488,12435193,80925836,42463414,77135531,10321588,4694209,39037517,
		37792478,49680980,82199284,20474741,83957459,66816282,91438994,62950604,47013502,85682655,4611269,
		95905259,1371589,66499018,64892035,40921545,98225108,42969214,97396380,89362180,15767889,50896944
	}
	pack[4][2]={
		23635815,40133511,38742075,77491079,40320754,30914564,76909279,2671330,18325492,55424270,3370104,
		93130021,21074344,94689635,99861526,79409334,12398280,20586572,46508640,95943058,91596726,52035300,
		87685879,39180960,59797187,11232355,17266660,52430902,38041940,2525268,95090813,71759912,90508760,
		43426903,65422840,79337169,3603242,23927545,20351153,13521194,12235475,96930127,2137678,84747429,
		73625877,93830681,5237827,2584136,49374988,72429240,7914843,30464153,78663366,30608985,54635862
	}
	pack[4][3]={
		37984162,61318483,12467005,99733359,25727454,72302403,70046172,86198326,70828912,82432018,19230407,
		73915051,95281259,55991637,81385346,37684215,31036355,2204140,4861205,10012614,28106077,98045062,
		82828051,12923641,36045450,37534148,1353770,6178850,4230620,62991886,99995595,35480699,45247637,
		32180819,44887817,92346415,25789292,95507060,91580102,25518020,66835946,98867329,84428023,78082039,
		27243130,67775894,60398723,53610653,89882100,88616795,73199638,36042825,96864811,83438826,23562407
	}
	pack[4][4]={
		42502956,54773234,52112003,88610708,97077563,22359980,68540058,57882509,41925941,31785398,80163754,
		98239899,3149764,59744639,83133491,29267084,66742250,12503902,96008713,77538567,4923662,60306104,
		93895605,34815282,82633308,23323812,59718521,37390589,91078716,54451023,97168905,73729209,17490535,
		43889633,16678947,87106146,32854013,21636650,89792713,3146695,25642998,11741041,75987257,44046281,
		78474168,44509898,71098407,63630268,23122036,25005816,51099515,88494120,14883228,50277973,87772572
	}
	pack[4][5]={
		47506081,95992081,11411223,47805931,3989465,76372778,581014,12014404,48009503,74593218,57043117,
		95169481,66506689,51960178,80764541,75367227,68836428
	}
	for _,v in ipairs(pack[4][1]) do table.insert(pack[4][5],v) end
	for _,v in ipairs(pack[4][2]) do table.insert(pack[4][5],v) end
	for _,v in ipairs(pack[4][3]) do table.insert(pack[4][5],v) end
	for _,v in ipairs(pack[4][4]) do table.insert(pack[4][5],v) end
local packopen=false
local handnum={[0]=5;[1]=5}

--DangerZone

local side={[0]={};[1]={}}
local function _prepSide(p,g)
	local c=g:GetFirst()
	while c do
		table.insert(side[p],c:GetOriginalCode())
		c=g:GetNext()
	end
end

local function _printDeck()
--[[ uncomment this if you want to have deck listing
	local io=require("io")
	for p=0,1 do
		local f=io.open("./deck/sealedpack"..p..".ydk","w+")
		f:write("#created by ...\n#main\n")
		local g=Duel.GetFieldGroup(p,LOCATION_DECK+LOCATION_HAND,0)
		local c=g:GetFirst()
		while c do
			f:write(c:GetOriginalCode().."\n")
			c=g:GetNext()
		end
		f:write("#extra\n")
		g=Duel.GetFieldGroup(p,LOCATION_EXTRA,0)
		c=g:GetFirst()
		while c do
			f:write(c:GetOriginalCode().."\n")
			c=g:GetNext()
		end
		f:write("!side\n")
		for _,i in ipairs(side[p]) do
			f:write(i.."\n")
		end
		f:close()
	end
--]]
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
	if packopen then e:Reset() return end
	packopen=true
	Duel.DisableShuffleCheck()
	--Hint
	Duel.Hint(HINT_CARD,0,s_id)
	for p=0,1 do
		local c=Duel.CreateToken(p,s_id)
		Duel.Remove(c,POS_FACEUP,REASON_RULE)
		Duel.Hint(HINT_CODE,p,s_id)
		--protection (steal Boss Duel xD)
		local e10=Effect.CreateEffect(c)
		e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e10:SetType(EFFECT_TYPE_SINGLE)
		e10:SetCode(EFFECT_CANNOT_TO_GRAVE)
		c:RegisterEffect(e10)
		local e11=e10:Clone()
		e11:SetCode(EFFECT_CANNOT_TO_HAND)
		c:RegisterEffect(e11)
		local e12=e10:Clone()
		e12:SetCode(EFFECT_CANNOT_TO_DECK) 
		c:RegisterEffect(e12)
		local e13=e10:Clone()
		e13:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		c:RegisterEffect(e13)
	end
	--note hand card
	handnum[0]=5 --Duel.GetFieldGroupCount(0,LOCATION_HAND,0)
	handnum[1]=5 --Duel.GetFieldGroupCount(1,LOCATION_HAND,0)
	--SetLP
	Duel.SetLP(0,8000)
	Duel.SetLP(1,8000)
	--FOR RANDOOM
	local rseed=0
	for i=1,6 do
		local r={Duel.TossCoin(i%2,5)}
		for n=1,5 do
			rseed=bit.lshift(rseed,1)+r[n]
		end
	end
	math.randomseed(rseed)
	local fg=Duel.GetFieldGroup(0,0x43,0x43)
	--remove all cards
	Duel.SendtoDeck(fg,nil,-2,REASON_RULE)
	--Open packs (let's keep it at 10 for now)
	local numpack=10
	for np=1,numpack do
		for p=0,1 do
			local n=math.random(4)
			Duel.Hint(HINT_OPSELECTED,p,aux.Stringid(4002,2+n))
			local g=Group.CreateGroup()
			for i=1,5 do
				local cpack=pack[n][i]
				local c=cpack[math.random(#cpack)]
				g:AddCard(Duel.CreateToken(p,c))
			end
			local ga=g:Filter(Card.IsAbleToHand,nil)
			Duel.SendtoHand(g,nil,REASON_RULE)
			Duel.ConfirmCards(p,g:Filter(Card.IsLocation,nil,LOCATION_EXTRA))
			Duel.SendtoDeck(g:Filter(Card.IsLocation,nil,LOCATION_HAND),nil,2,REASON_RULE)
		end
	end
	--next step
	--Players remove from each deck until card>=40 (optional)
	local rg=Group.CreateGroup()
	for p=0,1 do
		Duel.ConfirmCards(p,Duel.GetFieldGroup(p,LOCATION_DECK+LOCATION_EXTRA,0))
		local num=Duel.GetFieldGroupCount(p,LOCATION_DECK,0)-40
		if num>0 and Duel.SelectYesNo(p,aux.Stringid(4002,7)) then
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_REMOVE)
			local g=Duel.GetFieldGroup(p,LOCATION_DECK,0):Select(p,1,num,nil)
			_prepSide(p,g)
			rg:Merge(g)
		end
	end
	if rg:GetCount()>0 then Duel.SendtoDeck(rg,nil,-2,REASON_RULE) end
	--next step
	--Shuffle deck and add card
	for p=0,1 do
		Duel.ShuffleDeck(p)
	end
	for p=0,1 do
		Duel.SendtoHand(Duel.GetDecktopGroup(p,handnum[p]),nil,REASON_RULE)
	end
	for p=0,1 do
		if Duel.SelectYesNo(p,aux.Stringid(4002,2)) then
			local sg=Duel.GetFieldGroup(p,LOCATION_HAND,0)
			local ct=sg:GetCount()
			Duel.SendtoDeck(sg,nil,1,REASON_RULE)
			--local c=sg:GetFirst()
			--while c do
			--	Duel.MoveSequence(c,1)
			--	c=sg:GetNext()
			--end
			Duel.SendtoHand(Duel.GetDecktopGroup(p,ct),nil,REASON_RULE)
		end
	end
	e:Reset()
	--if someone wants/needs a deck listing (local hosting only), the function itself can be uncommented
	_printDeck()
end

--Nocheat zone

function scard.flag_chk(c)
	return c:GetFlagEffect(s_id)==0
end

function scard.nt_cd(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()>1 and Duel.IsExistingMatchingCard(scard.flag_chk,Duel.GetTurnPlayer(),0x43,0,1,nil)
end

function scard.nt_op(e,tp,eg,ep,ev,re,r,rp)
	Duel.DisableShuffleCheck()
	--Hint
	local p=Duel.GetTurnPlayer()
	Duel.Hint(HINT_CARD,p,s_id)
	Duel.Hint(HINT_CODE,p,s_id)
	--note hand card
	local hn=5 --Duel.GetFieldGroupCount(p,LOCATION_HAND,0)
	local fg=Duel.GetMatchingGroup(scard.flag_chk,p,0x43,0,nil)
	--remove all cards
	Duel.SendtoDeck(fg,nil,-2,REASON_RULE)
	--Open packs (let's keep it at 10 for now)
	local numpack=10
	for np=1,numpack do
		local n=math.random(4)
		Duel.Hint(HINT_OPSELECTED,p,aux.Stringid(4002,2+n))
		local g=Group.CreateGroup()
		for i=1,5 do
			local cpack=pack[n][i]
			local c=cpack[math.random(#cpack)]
			g:AddCard(Duel.CreateToken(p,c))
		end
		local ga=g:Filter(Card.IsAbleToHand,nil)
		Duel.SendtoHand(g,nil,REASON_RULE)
		Duel.ConfirmCards(p,g:Filter(Card.IsLocation,nil,LOCATION_EXTRA))
		Duel.SendtoDeck(g:Filter(Card.IsLocation,nil,LOCATION_HAND),nil,2,REASON_RULE)
	end
	--next step
	--Players remove from each deck until card>=40 (optional)
	local rg=Group.CreateGroup()
	Duel.ConfirmCards(p,Duel.GetFieldGroup(p,LOCATION_DECK+LOCATION_EXTRA,0))
	local num=Duel.GetFieldGroupCount(p,LOCATION_DECK,0)-40
	if num>0 and Duel.SelectYesNo(p,aux.Stringid(4002,7)) then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_REMOVE)
		local g=Duel.GetFieldGroup(p,LOCATION_DECK,0):Select(p,1,num,nil)
		rg:Merge(g)
	end
	if rg:GetCount()>0 then Duel.SendtoDeck(rg,nil,-2,REASON_RULE) end
	--next step
	--Shuffle deck and add card
	Duel.ShuffleDeck(p)
	Duel.SendtoHand(Duel.GetDecktopGroup(p,hn),nil,REASON_RULE)
	if Duel.SelectYesNo(p,aux.Stringid(4002,2)) then
		local sg=Duel.GetFieldGroup(p,LOCATION_HAND,0)
		local ct=sg:GetCount()
		Duel.SendtoDeck(sg,nil,1,REASON_RULE)
		--local c=sg:GetFirst()
		--while c do
		--	Duel.MoveSequence(c,1)
		--	c=sg:GetNext()
		--end
		Duel.SendtoHand(Duel.GetDecktopGroup(p,ct),nil,REASON_RULE)
	end
end

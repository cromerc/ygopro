--Numeron Chaos Ritual
function c511000295.initial_effect(c)
	function aux.AddXyzProcedure(c,f,lv,ct,alterf,desc,maxct,op)
		local code=c:GetOriginalCode()
		local mt=_G["c" .. code]
		if f then
			mt.xyz_filter=function(mc) return mc and f(mc) end
		else
			mt.xyz_filter=function(mc) return true end
		end
		mt.minxyzct=ct
		if not maxct then
			mt.maxxyzct=ct
		else
			if maxct==5 and code~=14306092 and code~=63504681 and code~=23776077 then
				mt.maxxyzct=99
			else
				mt.maxxyzct=maxct
			end
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		e1:SetRange(LOCATION_EXTRA)
		if not maxct then maxct=ct end
		if alterf then
			e1:SetCondition(Auxiliary.XyzCondition2(f,lv,ct,maxct,alterf,desc,op))
			e1:SetTarget(Auxiliary.XyzTarget2(f,lv,ct,maxct,alterf,desc,op))
			e1:SetOperation(Auxiliary.XyzOperation2(f,lv,ct,maxct,alterf,desc,op))
		else
			e1:SetCondition(Auxiliary.XyzCondition(f,lv,ct,maxct))
			e1:SetTarget(Auxiliary.XyzTarget(f,lv,ct,maxct))
			e1:SetOperation(Auxiliary.XyzOperation(f,lv,ct,maxct))
		end
		e1:SetValue(SUMMON_TYPE_XYZ)
		c:RegisterEffect(e1)
	end
	
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000295.condition)
	e1:SetTarget(c511000295.target)
	e1:SetOperation(c511000295.activate)
	c:RegisterEffect(e1)
	if not c511000295.global_check then
		c511000295.global_check=true
		c511000295[0]=false
		c511000295[1]=false
		c511000295[2]=Group.CreateGroup()
		c511000295[2]:KeepAlive()
		c511000295[3]=Group.CreateGroup()
		c511000295[3]:KeepAlive()
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetCode(EVENT_DESTROYED)
		ge1:SetOperation(c511000295.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511000295.clear)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge3:SetCode(EVENT_REMOVE)
		ge3:SetOperation(c511000295.matchk)
		Duel.RegisterEffect(ge3,0)
		local ge4=ge3:Clone()
		ge4:SetCode(EVENT_TO_HAND)
		Duel.RegisterEffect(ge4,0)
		local ge5=ge3:Clone()
		ge5:SetCode(EVENT_TO_DECK)
		Duel.RegisterEffect(ge5,0)
		local ge6=ge3:Clone()
		ge6:SetCode(EVENT_TO_GRAVE)
		Duel.RegisterEffect(ge6,0)
		local ge7=ge3:Clone()
		ge7:SetCode(EVENT_LEAVE_FIELD)
		Duel.RegisterEffect(ge7,0)
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e2:SetCode(EVENT_ADJUST)
	e2:SetCountLimit(1)
	e2:SetOperation(c511000295.chk)
	e2:SetLabelObject(e1)
	Duel.RegisterEffect(e2,0)
end
function c511000295.cfilter(c)
	return c:GetPreviousCodeOnField()==511000277
end
function c511000295.checkop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000295.cfilter,nil)
	local tc=g:GetFirst()
	while tc do
		c511000295[tc:GetPreviousControler()]=true
		tc=g:GetNext()
	end
end
function c511000295.matchk(e,tp,eg,ep,ev,re,r,rp)
	c511000295[2]:Clear()
	c511000295[3]:Clear()
	local g1=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_GRAVE,0,nil,0x48)
	local g2=Duel.GetMatchingGroup(Card.IsSetCard,1-tp,LOCATION_GRAVE,0,nil,0x48)
	local tc1=g1:GetFirst()
	while tc1 do
		local token=Duel.CreateToken(tp,tc1:GetOriginalCode())
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_XYZ_LEVEL)
		e1:SetValue(12)
		token:RegisterEffect(e1)
		c511000295[tp+2]:AddCard(token)
		tc1=g1:GetNext()
	end
	local tc2=g2:GetFirst()
	while tc2 do
		local token=Duel.CreateToken(1-tp,tc2:GetOriginalCode())
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_XYZ_LEVEL)
		e2:SetValue(12)
		token:RegisterEffect(e2)
		c511000295[1-tp+2]:AddCard(token)
		tc2=g2:GetNext()
	end
end
function c511000295.clear(e,tp,eg,ep,ev,re,r,rp)
	c511000295[0]=false
	c511000295[1]=false
end
function c511000295.chk(e,tp,eg,ep,ev,re,r,rp)
	local tck=Duel.CreateToken(tp,419)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetValue(12)
	tck:RegisterEffect(e1)
	e:GetLabelObject():SetLabelObject(tck)
end
function c511000295.condition(e,tp,eg,ep,ev,re,r,rp)
	return c511000295[tp]
end
function c511000295.mfilter(c,xyz,tck)
	return xyz.xyz_filter(tck) and c:IsCode(511000275)
end
function c511000295.matfilter(c,xyz)
	return xyz.xyz_filter(c) and c:IsSetCard(0x48)
end
function c511000295.xyzfilter(c,e,tp,tck)
	return c:GetRank()==12 and (c.minxyzct==5 or c.maxxyzct>=5) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
		and Duel.IsExistingMatchingCard(c511000295.mfilter,tp,LOCATION_GRAVE,0,1,nil,c,tck)
		and c511000295[tp+2]:IsExists(c511000295.matfilter,4,nil,c)
end
function c511000295.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tck=e:GetLabelObject()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511000295.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,tck) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511000295.activate(e,tp,eg,ep,ev,re,r,rp)
	local tck=e:GetLabelObject()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local xyzg=Duel.GetMatchingGroup(c511000295.xyzfilter,tp,LOCATION_EXTRA,0,nil,e,tp,tck)
	if xyzg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local mat1=Duel.SelectMatchingCard(tp,c511000295.mfilter,tp,LOCATION_GRAVE,0,1,1,nil,xyz,tck)
		local g=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_GRAVE,0,nil,0x48)
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_XYZ_LEVEL)
			e1:SetValue(12)
			e1:SetReset(RESET_CHAIN)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
		end
		local mat2=g:FilterSelect(tp,c511000295.matfilter,4,4,nil,xyz)
		mat1:Merge(mat2)
		Duel.HintSelection(mat1)
		xyz:SetMaterial(mat1)
		Duel.Overlay(xyz,mat1)
		Duel.SpecialSummon(xyz,SUMMON_TYPE_XYZ,tp,tp,true,false,POS_FACEUP)
		xyz:CompleteProcedure()
	end
end

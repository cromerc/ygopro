--Modify Deep Blue
function c511002769.initial_effect(c)
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
	e1:SetLabel(0)
	e1:SetCost(c511002769.cost)
	e1:SetTarget(c511002769.target)
	e1:SetOperation(c511002769.activate)
	c:RegisterEffect(e1)
end
function c511002769.filter(c,rk)
	return c:GetLevel()==rk
end
function c511002769.xyzfilter(c,mg)
	local ct=c.minxyzct
	return c:IsXyzSummonable(mg) and ct<=mg:GetCount() and mg:IsExists(c511002769.mfilter,ct,nil,c)
end
function c511002769.mfilter(c,xyz)
	return xyz.xyz_filter(c) and c:IsCanBeXyzMaterial(xyz)
end
function c511002769.cfilter(c,e,tp)
	local rk=c:GetRank()
	local mg=Duel.GetMatchingGroup(c511002769.filter,tp,LOCATION_DECK,0,nil,rk)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsAbleToRemoveAsCost() 
		and mg:GetCount()>1 and Duel.IsExistingMatchingCard(c511002769.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,mg)
end
function c511002769.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511002769.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511002769.cfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=Duel.SelectMatchingCard(tp,c511002769.cfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
	local rk=rg:GetFirst():GetRank()
	Duel.SetTargetParam(rk)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511002769.activate(e,tp,eg,ep,ev,re,r,rp)
	local rk=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local mg=Duel.GetMatchingGroup(c511002769.filter,tp,LOCATION_DECK,0,nil,rk)
	local xyzg=Duel.GetMatchingGroup(c511002769.xyzfilter,tp,LOCATION_EXTRA,0,nil,mg)
	if xyzg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
		local ct=xyz.minxyzct
		local ct2=xyz.maxxyzct
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local g=mg:FilterSelect(tp,c511002769.mfilter,ct,ct2,nil,xyz)
		Duel.XyzSummon(tp,xyz,g)
	end
end

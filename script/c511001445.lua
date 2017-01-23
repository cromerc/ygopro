--Halfway to Forever
function c511001445.initial_effect(c)
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
	e1:SetTarget(c511001445.target)
	e1:SetOperation(c511001445.activate)
	c:RegisterEffect(e1)
end
function c511001445.filter(c,tid)
	return c:GetTurnID()==tid and c:IsReason(REASON_BATTLE)
end
function c511001445.xyzfilter(c,mg)
	return c:IsXyzSummonable(mg) and (c.minxyzct==2 or c.maxxyzct>=2)
end
function c511001445.mfilter1(c,exg)
	return exg:IsExists(c511001445.mfilter2,1,nil,c)
end
function c511001445.mfilter2(c,mc)
	return c.xyz_filter(mc)
end
function c511001445.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tid=Duel.GetTurnCount()
	local mg=Duel.GetMatchingGroup(c511001445.filter,tp,LOCATION_GRAVE,0,nil,tid)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and mg:GetCount()>1
		and Duel.IsExistingMatchingCard(c511001445.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,mg) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511001445.activate(e,tp,eg,ep,ev,re,r,rp)
	local tid=Duel.GetTurnCount()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local mg=Duel.GetMatchingGroup(c511001445.filter,tp,LOCATION_GRAVE,0,nil,tid)
	local exg=Duel.GetMatchingGroup(c511001445.xyzfilter,tp,LOCATION_EXTRA,0,nil,mg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local sg1=mg:FilterSelect(tp,c511001445.mfilter1,1,1,nil,exg)
	local tc1=sg1:GetFirst()
	local exg2=exg:Filter(c511001445.mfilter2,nil,tc1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local sg2=mg:FilterSelect(tp,c511001445.mfilter1,1,1,tc1,exg2)
	sg1:Merge(sg2)
	local xyzg=Duel.GetMatchingGroup(c511001445.xyzfilter,tp,LOCATION_EXTRA,0,nil,sg1)
	if xyzg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
		xyz:SetMaterial(sg1)
		Duel.Overlay(xyz,sg1)
		Duel.SpecialSummon(xyz,SUMMON_TYPE_XYZ,tp,tp,true,false,POS_FACEUP)
		xyz:CompleteProcedure()
	end
end

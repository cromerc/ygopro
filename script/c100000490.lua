--デステニー・オーバーレイ
function c100000490.initial_effect(c)
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
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000490.target)
	e1:SetOperation(c100000490.activate)
	c:RegisterEffect(e1)
end
function c100000490.filter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e) and not c:IsType(TYPE_TOKEN)
end
function c100000490.xyzfilter(c,mg)
	return c:IsXyzSummonable(mg)
end
function c100000490.xyzfilter2(c,mg,ct)
	return c:IsXyzSummonable(mg) and (c.minxyzct==ct or c.maxxyzct>=ct)
end
function c100000490.mfilter1(c,exg)
	return exg:IsExists(c100000490.mfilter2,1,nil,c)
end
function c100000490.mfilter2(c,mc)
	return c.xyz_filter(mc)
end
function c100000490.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local mg=Duel.GetMatchingGroup(c100000490.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e)
	if chk==0 then return mg:GetCount()>0 and Duel.IsExistingMatchingCard(c100000490.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,mg) end
	local exg=Duel.GetMatchingGroup(c100000490.xyzfilter,tp,LOCATION_EXTRA,0,nil,mg)
	local extc=exg:GetFirst()
	local minct=99
	local maxct=0
	while extc do
		if extc.minxyzct<minct then
			minct=extc.minxyzct
		end
		if extc.maxxyzct>maxct then
			maxct=extc.maxxyzct
		end
		extc=exg:GetNext()
	end
	local g=mg:Filter(c100000490.mfilter1,nil,exg)
	local mgt=Group.CreateGroup()
	local ct=0
	repeat
		mgt=g:Select(tp,minct,maxct,nil)
		ct=mgt:GetCount()
	until exg:IsExists(c100000490.xyzfilter2,1,nil,mgt,ct)
	Duel.SetTargetCard(mgt)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c100000490.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local xyzg=Duel.GetMatchingGroup(c100000490.xyzfilter2,tp,LOCATION_EXTRA,0,nil,g,g:GetCount())
	if xyzg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
		Duel.XyzSummon(tp,xyz,g)
	end
end

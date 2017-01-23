--Re-Xyz
function c511000829.initial_effect(c)
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
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000829.target)
	e1:SetOperation(c511000829.operation)
	c:RegisterEffect(e1)
end
function c511000829.filter(c,e,tp)
	local ct=c.minxyzct
	return c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,true) and c:IsType(TYPE_XYZ)
		and Duel.IsExistingTarget(c511000829.matfilter,tp,LOCATION_GRAVE,0,1,nil,tp,ct)
		and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511000829.matfilter(c,tp,ct)
	return c:GetLevel()>0
		and Duel.IsExistingTarget(c511000829.matfilter2,tp,LOCATION_GRAVE,0,ct-1,c,c:GetLevel())
end
function c511000829.matfilter2(c,lv)
	return c:GetLevel()==lv
end
function c511000829.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511000829.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511000829.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511000829.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	local ct=g:GetFirst().minxyzct
	local ct2=g:GetFirst().maxxyzct
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local mat=Duel.SelectTarget(tp,c511000829.matfilter,tp,LOCATION_GRAVE,0,1,1,nil,tp,ct)
	local lv=mat:GetFirst():GetLevel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local mat2=Duel.SelectTarget(tp,c511000829.matfilter2,tp,LOCATION_GRAVE,0,ct-1,ct2-1,mat:GetFirst(),lv)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511000829.xyzfilter(c)
	return not c:IsType(TYPE_XYZ)
end
function c511000829.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:Filter(Card.IsType,nil,TYPE_XYZ):GetFirst()
	g=g:Filter(c511000829.xyzfilter,nil)
	tc:SetMaterial(g)
	Duel.Overlay(tc,g)
	Duel.SpecialSummon(tc,SUMMON_TYPE_XYZ,tp,tp,false,true,POS_FACEUP)
	tc:CompleteProcedure()
end

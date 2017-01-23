--Dimension Xyz
function c511000698.initial_effect(c)
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
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000698.condition)
	e1:SetTarget(c511000698.target)
	e1:SetOperation(c511000698.operation)
	c:RegisterEffect(e1)
end
function c511000698.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=1000
end
function c511000698.filter(c,e,tp)
	return Duel.IsExistingMatchingCard(c511000698.filter2,tp,0x1E,0,2,c,c:GetLevel(),c:GetCode())
		and Duel.IsExistingMatchingCard(c511000698.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c:GetLevel())
end
function c511000698.filter2(c,lv,code)
	return c:GetLevel()==lv and c:IsCode(code)
end
function c511000698.xyzfilter(c,e,tp,lv)
	return c:GetRank()==lv and (c.minxyzct==3 or c.maxxyzct>=3) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c511000698.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000698.filter,tp,0x1E,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511000698.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g1=Duel.SelectMatchingCard(tp,c511000698.filter,tp,0x1E,0,1,1,nil,e,tp)
	local gx=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g2=Duel.SelectMatchingCard(tp,c511000698.filter2,tp,0x1E,0,2,2,gx,gx:GetLevel(),gx:GetCode())
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local x=Duel.SelectMatchingCard(tp,c511000698.xyzfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,gx:GetLevel())
	local xyz=x:GetFirst()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetOperation(c511000698.xyzop)
	e1:SetReset(RESET_CHAIN)
	e1:SetValue(SUMMON_TYPE_XYZ)
	e1:SetLabelObject(g1)
	xyz:RegisterEffect(e1)
	Duel.XyzSummon(tp,xyz,nil)
end
function c511000698.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og)
	local mat=e:GetLabelObject()
	c:SetMaterial(mat)
	Duel.Overlay(c,mat)
end

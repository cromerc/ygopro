--Medicine Eater
function c511002440.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c511002440.condition)
	e1:SetTarget(c511002440.target)
	e1:SetOperation(c511002440.activate)
	c:RegisterEffect(e1)
end
function c511002440.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return bit.band(tc:GetSummonType(),SUMMON_TYPE_ADVANCE)==SUMMON_TYPE_ADVANCE
		and tc:GetMaterialCount()>0
end
function c511002440.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=eg:GetFirst()
	local g=tc:GetMaterial()
	if chkc then return g:IsContains(chkc) and chkc:IsCanBeEffectTarget(e) end
	if chk==0 then return g:IsExists(Card.IsCanBeEffectTarget,1,nil,e) end
	if g:GetCount()>1 then
		g=g:FilterSelect(tp,Card.IsCanBeEffectTarget,1,1,nil,e)
	end
	Duel.SetTargetCard(g)
	tc:CreateEffectRelation(e)
end
function c511002440.activate(e,tp,eg,ep,ev,re,r,rp)
	local sc=eg:GetFirst()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and sc and sc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(tc:GetAttack()/2)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		sc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetValue(tc:GetDefense()/2)
		sc:RegisterEffect(e2)
		sc:CopyEffect(tc:GetOriginalCode(),RESET_EVENT+0x1fe0000,1)
	end
end

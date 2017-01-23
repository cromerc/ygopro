--ナチュル・バンブーシュート
function c511002035.initial_effect(c)
	--mat check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetValue(c511002035.valcheck)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c511002035.regcon)
	e2:SetOperation(c511002035.regop)
	c:RegisterEffect(e2)
	e2:SetLabelObject(e1)
end
function c511002035.valcheck(e,c)
	local g=c:GetMaterial()
	local flag=0
	if g:IsExists(Card.IsSetCard,1,nil,0x2310) then flag=1 end
	if g:IsExists(Card.IsCode,1,nil,39389320) then flag=1 end
	if g:IsExists(Card.IsCode,1,nil,40453765) then flag=1 end
	if g:IsExists(Card.IsCode,1,nil,20394040) then flag=1 end
	e:SetLabel(flag)
end
function c511002035.regcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_ADVANCE)==SUMMON_TYPE_ADVANCE
		and e:GetLabelObject():GetLabel()~=0
end
function c511002035.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e2:SetCondition(c511002035.atcon)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
end
function c511002035.atcon(e)
	return e:GetHandler():GetAttackAnnouncedCount()>0
end

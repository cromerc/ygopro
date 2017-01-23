--Arcanatic Doomscythe
function c511000601.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000601.target)
	e1:SetOperation(c511000601.activate)
	c:RegisterEffect(e1)
end
function c511000601.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave() and c:IsSetCard(0x5)
end
function c511000601.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000601.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c511000601.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511000601.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCategory(CATEGORY_DAMAGE)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_BATTLE_DESTROYED)
		e1:SetCondition(c511000601.damcon)
		e1:SetOperation(c511000601.damop)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511000601.cfil(c,tp)
	return c:IsReason(REASON_BATTLE) and c:GetPreviousControler()==tp
end
function c511000601.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000601.cfil,1,nil,1-tp)
end
function c511000601.damop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000601.cfil,nil,1-tp)
	local tc=g:GetFirst()
	Duel.Damage(1-tp,tc:GetAttack(),REASON_EFFECT)
end

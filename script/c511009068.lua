--Abyss Script - Abode of the Fire Dragon
function c511009068.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511009068.target)
	e1:SetOperation(c511009068.activate)
	c:RegisterEffect(e1)
end
function c511009068.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x10ec)
end
function c511009068.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511009068.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009068.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511009068.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c511009068.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then	
		--damage
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetDescription(aux.Stringid(100000210,0))
		e2:SetCategory(CATEGORY_DAMAGE)
		e2:SetCode(EVENT_BATTLE_DESTROYING)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetCondition(c511009068.condition)
		e2:SetTarget(c511009068.target2)		
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetOperation(c511009068.operation)
		tc:RegisterEffect(e2)
	end
end
function c511009068.rmfilter(c)
	return c:IsAbleToRemove()
end
function c511009068.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:GetBattleTarget():IsType(TYPE_MONSTER)
end
function c511009068.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_EXTRA)
	if chk==0 then return g:FilterCount(c511009068.rmfilter,nil)>=3 end
end
function c511009068.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_EXTRA)
	if g:GetCount()<3 then return end
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,0,LOCATION_EXTRA,3,3,nil)
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
end

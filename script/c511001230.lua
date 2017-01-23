--ディマンドマン
function c511001230.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001230,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1)
	e1:SetCondition(c511001230.poscon)
	e1:SetTarget(c511001230.postg)
	e1:SetOperation(c511001230.posop)
	c:RegisterEffect(e1)
end
function c511001230.poscon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=tp and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)
end
function c511001230.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsPosition(POS_DEFENSE) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsPosition,tp,0,LOCATION_MZONE,1,nil,POS_DEFENSE) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DEFENSE)
	local g=Duel.SelectTarget(tp,Card.IsPosition,tp,0,LOCATION_MZONE,1,1,nil,POS_DEFENSE)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c511001230.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsPosition(POS_DEFENSE) then
		Duel.ChangePosition(tc,POS_FACEUP_ATTACK)
	end
end

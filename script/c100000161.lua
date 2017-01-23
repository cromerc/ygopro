--クリアー・ファントム
function c100000161.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_REMOVE_ATTRIBUTE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100000161.ratg)
	e1:SetValue(ATTRIBUTE_DARK)
	c:RegisterEffect(e1)	
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000161,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c100000161.condition)
	e2:SetTarget(c100000161.target)
	e2:SetOperation(c100000161.operation)
	c:RegisterEffect(e2)
end
function c100000161.ratg(e)
	return e:GetHandler()
end
function c100000161.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and c:GetPreviousControler()==tp
		and c:GetReasonCard():IsRelateToBattle() and c:IsReason(REASON_BATTLE) 
		and c:GetBattlePosition()==POS_FACEUP_ATTACK
end
function c100000161.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	local rc=e:GetHandler():GetReasonCard()
	rc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,rc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,3)
end
function c100000161.operation(e,tp,eg,ep,ev,re,r,rp)
	local rc=e:GetHandler():GetReasonCard()
	if rc:IsRelateToEffect(e) then
		Duel.Destroy(rc,REASON_EFFECT)
	end
	Duel.DiscardDeck(1-tp,3,REASON_EFFECT)
end
--Fiend's Hand (DOR)
--Scripted by GameMaster (GM)
function c511005608.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511005608,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511005608.condition)
	e1:SetTarget(c511005608.target)
	e1:SetOperation(c511005608.operation)
	c:RegisterEffect(e1)
end
function c511005608.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
		and e:GetHandler():GetReasonCard():IsRelateToBattle()
end
function c511005608.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local rc=e:GetHandler():GetReasonCard()
	Duel.SetTargetCard(rc)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,rc,1,0,0)
end
function c511005608.operation(e,tp,eg,ep,ev,re,r,rp)
	local rc=Duel.GetFirstTarget()
	if rc:IsRelateToEffect(e) then
		Duel.Destroy(rc,REASON_EFFECT)
	end
end

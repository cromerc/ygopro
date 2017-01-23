--Dragocytus, the Impure Underworld Dragon
function c511000807.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)	
	--gain atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000807,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetCountLimit(1)
	e2:SetCondition(c511000807.atkcon)
	e2:SetOperation(c511000807.atkop)
	c:RegisterEffect(e2)
	--damage lp
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000807,1))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PREDRAW)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e3:SetCondition(c511000807.damcon)
	e3:SetTarget(c511000807.damtg)
	e3:SetOperation(c511000807.damop)
	c:RegisterEffect(e3)
	--damage lp
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000807,1))
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e4:SetCondition(c511000807.damcon)
	e4:SetTarget(c511000807.damtg)
	e4:SetOperation(c511000807.damop)
	c:RegisterEffect(e4)
end
function c511000807.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc:IsReason(REASON_BATTLE)
end
function c511000807.atkop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c511000807.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	if Duel.GetTurnPlayer()==tp and Duel.GetActivityCount(tp,ACTIVITY_SUMMON)==0
		and Duel.GetActivityCount(tp,ACTIVITY_FLIPSUMMON)==0 and Duel.GetActivityCount(tp,ACTIVITY_SPSUMMON)==0 
		and Duel.GetActivityCount(tp,ACTIVITY_ATTACK)==0 then
		Duel.RaiseEvent(e:GetHandler(),511000807,e,0,0,tp,0)
	end
end
function c511000807.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511000807.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c511000807.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		local dam=g:GetFirst():GetAttack()
		Duel.Damage(p,dam,REASON_EFFECT)
	end
end

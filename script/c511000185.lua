--Damage Pot
function c511000185.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)	
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511000185.condition)
	e1:SetOperation(c511000185.activate)
	c:RegisterEffect(e1)
end
function c511000185.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>0
end
function c511000185.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511000185.damopx)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000185,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetLabel(Duel.GetBattleDamage(tp))
	e2:SetTarget(c511000185.damtg)
	e2:SetOperation(c511000185.damop)
	e2:SetReset(RESET_EVENT+0x1020000)
	c:RegisterEffect(e2)
end
function c511000185.damopx(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
	Duel.ChangeBattleDamage(1-tp,0)
end
function c511000185.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,e:GetLabel())
end
function c511000185.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(tp,e:GetLabel(),REASON_EFFECT,true)
	Duel.Damage(1-tp,e:GetLabel(),REASON_EFFECT,true)
	Duel.RDComplete()
end

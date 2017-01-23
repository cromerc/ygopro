--DD魔導賢者ガリレイ
function c511001043.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--scale change
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetDescription(aux.Stringid(511001043,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCountLimit(1)
	e2:SetCondition(c511001043.sccon)
	e2:SetTarget(c511001043.sctg)
	e2:SetOperation(c511001043.scop)
	c:RegisterEffect(e2)
	--atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetCondition(c511001043.con)
	e3:SetOperation(c511001043.op)
	c:RegisterEffect(e3)
end
function c511001043.sccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511001043.filter(c,lv)
	return c:IsFaceup() and c:IsAbleToGrave() and c:IsLevelBelow(lv) and c:GetSummonType()==SUMMON_TYPE_PENDULUM
end
function c511001043.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local scl=e:GetHandler():GetLeftScale()*2
	local g=Duel.GetMatchingGroup(c511001043.filter,tp,LOCATION_MZONE,0,nil,sc1)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function c511001043.scop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local scl=c:GetLeftScale()*2
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LSCALE)
	e1:SetValue(scl)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CHANGE_RSCALE)
	c:RegisterEffect(e2)
	local g=Duel.GetMatchingGroup(c511001043.filter,tp,LOCATION_MZONE,0,nil,scl)
	if g:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c511001043.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc
end
function c511001043.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() then
		local atk=0
		local rp1=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
		local rp2=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
		if rp1 then
			atk=atk+rp1:GetAttack()
		end
		if rp2 then
			atk=atk+rp2:GetAttack()
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(atk)
		c:RegisterEffect(e1)
	end
end

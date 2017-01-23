--Scripted by Eerie Code
--Performapal Odd-Eyes Unicorn
function c700000010.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--Increase ATK
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(700000010,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c700000010.atkcon)
	e2:SetTarget(c700000010.atktg)
	e2:SetOperation(c700000010.atkop)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetValue(c700000010.atkval)
	c:RegisterEffect(e3)
end

function c700000010.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(tp) and at:IsSetCard(0x99)
end
function c700000010.atkfil(c)
	return c:IsFaceup() and c:IsSetCard(0x9f) and c:GetAttack()>0
end
function c700000010.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttacker():IsCanBeEffectTarget(e) and Duel.IsExistingMatchingCard(c700000010.atkfil,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetTargetCard(Group.FromCards(Duel.GetAttacker()))
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,Duel.GetAttacker(),1,0,0)
end
function c700000010.atkop(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetFirstTarget()
	local g=Duel.SelectMatchingCard(tp,c700000010.atkfil,tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()>0 then
		local tg=g:GetFirst()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCategory(CATEGORY_ATKCHANGE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(tg:GetAttack())
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		at:RegisterEffect(e1)
	end
end

function c700000010.atkfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x99) or c:IsSetCard(0x9f))
end
function c700000010.atkval(e,c)
	if c700000010.atkfilter(c) then
		return Duel.GetMatchingGroupCount(c700000010.atkfilter,c:GetControler(),LOCATION_MZONE,0,nil)*100
	else return 0 end	
end
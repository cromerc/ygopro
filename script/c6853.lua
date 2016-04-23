--Scripted by Eerie Code
--Katanagami - Shiranui
function c6853.initial_effect(c)
	c:SetSPSummonOnce(6853)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_ZOMBIE),aux.NonTuner(Card.IsRace,RACE_ZOMBIE),1)
	c:EnableReviveLimit()
	--Change position
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6853,0))
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c6853.postg)
	e1:SetOperation(c6853.posop)
	c:RegisterEffect(e1)
	--Reduce ATK
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6853,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetTarget(c6853.target)
	e2:SetOperation(c6853.operation)
	c:RegisterEffect(e2)
end

function c6853.cposfil(c,tp)
	return c:IsRace(RACE_ZOMBIE) and c:IsAbleToDeck() and Duel.IsExistingMatchingCard(c6853.posfil,tp,0,LOCATION_MZONE,1,nil,c:GetAttack())
end
function c6853.posfil(c,atk)
	return c:IsPosition(POS_ATTACK) and c:GetAttack()<=atk
end
function c6853.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c:IsLocation(LOCATION_REMOVED) and c:IsControler(tp) and c6853.cposfil(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c6853.cposfil,tp,LOCATION_REMOVED,0,1,nil,tp) end
	local tg=Duel.SelectTarget(tp,c6853.cposfil,tp,LOCATION_REMOVED,0,1,1,nil,tp)
	local g=Duel.GetMatchingGroup(c6853.posfil,tp,0,LOCATION_MZONE,nil,tg:GetFirst():GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_TODECK,tg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c6853.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local g=Duel.GetMatchingGroup(c6853.posfil,tp,0,LOCATION_MZONE,nil,tc:GetAttack())
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)~=0 then
		Duel.ChangePosition(g,POS_FACEUP_DEFENCE,POS_FACEUP_DEFENCE,POS_FACEUP_DEFENCE,POS_FACEUP_DEFENCE)
	end
end

function c6853.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c6853.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g,1,0,0)
end
function c6853.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-500)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
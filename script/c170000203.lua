--Legendary Knight Critias
function c170000203.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--Absorb Traps
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c170000203.con)
	e2:SetTarget(c170000203.tg)
	e2:SetOperation(c170000203.op)
	c:RegisterEffect(e2)
end
function c170000203.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingTarget(c170000203.filter1,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil)
	and e:GetLabel()~=1 and e:GetHandler()==Duel.GetAttacker() and e:GetHandler():GetBattleTarget()~=nil
	or Duel.IsExistingTarget(c170000203.filter1,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil)
	and e:GetLabel()~=1 and e:GetHandler()==Duel.GetAttackTarget() and e:GetHandler():GetBattleTarget()~=nil
end
function c170000203.filter1(c,e,tp,eg,ep,ev,re,r,rp)
	return c:CheckActivateEffect(false,true,false)~=nil and c:GetType()==TYPE_TRAP and c:IsAbleToRemove()
end
function c170000203.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c170000203.filter1,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil) end
	local tc=Duel.SelectMatchingCard(tp,c170000203.filter1,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil)
	e:SetLabel(1)
	local te,eg,ep,ev,re,r,rp=tc:GetFirst():CheckActivateEffect(false,true,true)
	e:SetLabelObject(tc:GetFirst())
	local tc=e:GetLabelObject()
	local te,eg,ep,ev,re,r,rp=tc:CheckActivateEffect(false,true,true)
	local tg=te:GetTarget()
	e:SetLabelObject(te)
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end
function c170000203.op(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
    if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
	e:SetLabel(0)
end
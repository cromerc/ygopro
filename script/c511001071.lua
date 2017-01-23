--Hero's Guard
function c511001071.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001071.condition)
	e1:SetTarget(c511001071.target)
	e1:SetOperation(c511001071.activate)
	c:RegisterEffect(e1)
end
function c511001071.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c511001071.cfilter(c)
	return c:IsSetCard(0x8) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c511001071.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local d=Duel.GetAttackTarget()
	if chk==0 then return (d and d:IsSetCard(0x8)) 
		or (Duel.IsExistingMatchingCard(c511001071.cfilter,tp,LOCATION_GRAVE,0,1,nil) and Duel.IsPlayerCanDraw(tp,1)) end
	if not d or not d:IsSetCard(0x8) then
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	end
end
function c511001071.filter(c,tp)
	return c:IsSetCard(0x8) and c:IsControler(tp)
end
function c511001071.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	local g=Group.FromCards(a,d)
	g=g:Filter(c511001071.filter,nil,tp)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
	local sg=Duel.GetMatchingGroup(c511001071.cfilter,tp,LOCATION_GRAVE,0,nil)
	if sg:GetCount()<=0 then return end
	if g:GetCount()<=0 or Duel.SelectYesNo(tp,aux.Stringid(52687916,2)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local rg=sg:Select(tp,1,1,nil)
		if Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)>0 then
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_FIELD)
			e2:SetCode(EFFECT_CHANGE_DAMAGE)
			e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
			e2:SetTargetRange(1,0)
			e2:SetValue(c511001071.damval)
			Duel.RegisterEffect(e2,tp)
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end
function c511001071.damval(e,re,val,r,rp,rc)
	if r==REASON_BATTLE then
		return val/2
	else return val end
end

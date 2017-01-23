--Gorgonic Temptaion
--scripted by GameMaster(GM)
function c511005598.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--choose atk target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCountLimit(1)
	--e2:SetTarget(c511005598.target)
	e2:SetOperation(c511005598.operation)
	c:RegisterEffect(e2)
end
c511005598.collection={ [37168514]=true; [37984162]=true; [64378261]=true; [90764875]=true; [84401683]=true; }
function c511005598.filter(c)
	return c:IsFaceup() and c511005598.collection[c:GetCode()]
end
function c511005598.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511005598.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetAttacker():IsControler(1-tp) end
end
function c511005598.operation(e,tp,eg,ep,ev,re,r,rp)
	local ats=eg:GetFirst():GetAttackableTarget()
	local at=Duel.GetAttackTarget()
	if ats:GetCount()==0 or (at and ats:GetCount()==1) then return end
	if Duel.SelectYesNo(tp,HINTMSG_EFFECT) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local g=ats:Select(tp,1,1,at)
		Duel.Hint(HINT_CARD,0,511005598)
		Duel.HintSelection(g)
		Duel.ChangeAttackTarget(g:GetFirst())
	end
end
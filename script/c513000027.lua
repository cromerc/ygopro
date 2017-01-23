--Ebon Sun
function c513000027.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--gain LP
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c513000027.rectg)
	e2:SetOperation(c513000027.recop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(87046457,0))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c513000027.sptg)
	e3:SetOperation(c513000027.spop)
	c:RegisterEffect(e3)
end
function c513000027.rectg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return eg:IsExists(Card.IsType,1,nil,TYPE_MONSTER) end
	local g=eg:Filter(Card.IsType,nil,TYPE_MONSTER)
	local sum=g:GetSum(Card.GetAttack)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(sum)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,sum)
end
function c513000027.recop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Recover(p,d,REASON_EFFECT)
	end
end
function c513000027.filter(c,e,tp)
	return c:IsPreviousLocation(LOCATION_GRAVE) and (not e or c:IsRelateToEffect(e)) 
		and c:GetPreviousControler()==tp
end
function c513000027.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c513000027.filter,1,nil,nil,tp) end
	Duel.SetTargetCard(eg)
end
function c513000027.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=eg:Filter(c513000027.filter,nil,e,tp)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(1000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end

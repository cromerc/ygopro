--血の咆哮－ブラッド・ロアー
function c100000272.initial_effect(c)
	c:EnableCounterPermit(0x92)
	c:SetCounterLimit(0x92,2)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE)
	c:RegisterEffect(e1)	
	--
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c100000272.con)
	e2:SetOperation(c100000272.op)
	c:RegisterEffect(e2)
	--destroy+DAMAGE
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(100000272,1))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c100000272.descost)
	e3:SetTarget(c100000272.destg)
	e3:SetOperation(c100000272.desop)
	c:RegisterEffect(e3)
end
function c100000272.tdfilter(c)
	return c:GetCode()==83965310 and c:IsFaceup()
end
function c100000272.con(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
	 and Duel.IsExistingMatchingCard(c100000272.tdfilter,tp,LOCATION_MZONE,0,1,nil)
	 and e:GetHandler():IsCanAddCounter(0x92,1)
end
function c100000272.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c and c:IsFaceup() and c:IsRelateToEffect(e) then
		c:AddCounter(0x92,1)
	end
end

function c100000272.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() and e:GetHandler():GetCounter(0x92)>1 end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c100000272.filter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c100000272.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c100000272.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000272.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c100000272.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c100000272.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local atk=tc:GetAttack()
		if Duel.Destroy(tc,REASON_EFFECT)>0 then
			Duel.Damage(1-tp,atk/2,REASON_EFFECT)
		end
	end
end

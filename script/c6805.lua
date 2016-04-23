--Scripted by Eerie Code
--Performapal Big Bite Turtle
function c6805.initial_effect(c)
	--Pendulum Summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--change level
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6805,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c6805.lvtg)
	e2:SetOperation(c6805.lvop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetDescription(aux.Stringid(6805,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetCondition(c6805.descon)
	e3:SetOperation(c6805.desop)
	c:RegisterEffect(e3)
end

function c6805.cfilter(c)
	return (c:IsSetCard(0x99) or c:IsSetCard(0x9f)) and not c:IsPublic()
end
function c6805.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6805.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local cg=Duel.SelectMatchingCard(tp,c6805.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,cg)
	Duel.ShuffleHand(tp)
	e:SetLabel(cg:GetFirst():GetCode())
end
function c6805.lvop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local code=e:GetLabel()
	local tg=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,nil,code)
	local tc=tg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(-1)
		e1:SetReset(RESET_EVENT+0xfe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=tg:GetNext()
	end
end

function c6805.descon(e,tp,eg,ep,ev,re,r,rp)
	local rc=e:GetHandler():GetReasonCard()
	return rc:IsRelateToBattle() and rc:IsDestructable()
end
--function c6805.destg(e,tp,eg,ep,ev,re,r,rp,chk)
--	local tc=e:GetHandler():GetReasonCard()
--	if chk==0 then return true end
--	if tc and tc:IsDestructable(e) then
--		Debug.Message("Target acquired")
--		e:SetLabelObject(tc)
--		Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
--	end
--end
function c6805.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetReasonCard()
	if tc and tc:IsRelateToBattle() and tc:IsDestructable() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
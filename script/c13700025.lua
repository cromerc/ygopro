--Hermit Youkai Sarenjinchuu
function c13700025.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTarget(c13700025.reptg)
	e2:SetValue(c13700025.repval)
	e2:SetOperation(c13700025.repop)
	c:RegisterEffect(e2)
	--to defence
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c13700025.potg)
	e1:SetOperation(c13700025.poop)
	c:RegisterEffect(e1)
	--target	
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c13700025.target)
	e2:SetValue(c13700025.tgvalue)
	c:RegisterEffect(e2)
end
function c13700025.repfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x1374) 
		and c:IsOnField() and c:IsControler(tp) and c:IsReason(REASON_EFFECT+REASON_BATTLE) and c:IsLocation(LOCATION_MZONE)
end
function c13700025.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c13700025.repfilter,1,nil,tp) end
	return Duel.SelectYesNo(tp,aux.Stringid(13700025,0))
end
function c13700025.repval(e,c)
	return c13700025.repfilter(c,e:GetHandlerPlayer())
end
function c13700025.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_REPLACE)
end

function c13700025.potg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsAttackPos() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c13700025.poop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsAttackPos() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENCE)
	end
end
function c13700025.target(e,c)
	return c:IsSetCard(0x1374) and c:IsType(TYPE_MONSTER) and c~=e:GetHandler()
end
function c13700025.tgvalue(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end

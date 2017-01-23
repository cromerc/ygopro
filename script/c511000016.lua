--Gate Defender (Script by RaiZZZ19)
function c511000016.initial_effect(c)
	--negate 1 attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000016,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511000016.nacon)
	e1:SetOperation(c511000016.naop)
	c:RegisterEffect(e1)
	--cannot be battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetCondition(c511000016.cbbtcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--Self-destruct
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000016,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511000016.sdcon)
    e3:SetTarget(c511000016.sdtg)
    e3:SetOperation(c511000016.operation)
    c:RegisterEffect(e3)
end
function c511000016.nacon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=eg:GetFirst()
	return bt:GetControler()==c:GetControler()
end
function c511000016.naop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
function c511000016.cbbtcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)>1
end
function c511000016.filter(c,tp)                                                     ---------affects one side of field----------------
	return c:IsReason(REASON_BATTLE) and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp and c:IsType(TYPE_MONSTER)
end
function c511000016.sdcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000016.filter,1,nil,tp)
end
function c511000016.sdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c511000016.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.Destroy(c,nil,REASON_EFFECT)
	end
end
--Lucky Trinket (DOR)
--scripted by GameMaster(GM)
function c511005616.initial_effect(c)
--atkdown
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511005616.atkcon)
	e1:SetOperation(c511005616.atkop)
	e1:SetCountLimit(1)
	e1:SetTarget(c511005616.target)
	c:RegisterEffect(e1)
end
function c511005616.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return  e:GetHandler():IsDefensePos() 
end

function c511005616.atkop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(c511005616.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
    local tc=g:GetFirst()
    while tc do
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(-100)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e1)
        tc=g:GetNext()
    end
end

function c511005616.filter(c)
return c:IsAttribute(0x20) and c:IsFaceup() 
end

function c511005616.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511005616.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511005616.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511005616.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
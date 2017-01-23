--Chaos Phantom Demon Armityle
function c511000253.initial_effect(c)
	c:EnableReviveLimit()
	--Special Summon with Dimension Fusion Destruction
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--Cannot be Destroyed by Battle
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--attack
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c511000253.atktg)
	e3:SetOperation(c511000253.atkop)
	c:RegisterEffect(e3)
	--Control
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(65305468,0))
	e4:SetCategory(CATEGORY_CONTROL)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c511000253.cttg)
	e4:SetOperation(c511000253.ctop)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(511000253,1))
	e5:SetCategory(CATEGORY_REMOVE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetCondition(c511000253.furycon)
	e5:SetTarget(c511000253.furytg)
	e5:SetOperation(c511000253.furyop)
	c:RegisterEffect(e5)
end
function c511000253.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:GetControler()~=tp and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return c:IsAttackable() 
		and Duel.IsExistingTarget(nil,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)	
end
function c511000253.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc and tc:IsRelateToEffect(e) 
		and c:IsAttackable() and not c:IsImmuneToEffect(e) and not tc:IsImmuneToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetReset(RESET_CHAIN)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(10000)
		c:RegisterEffect(e1)
		Duel.CalculateDamage(c,tc)
	end
end
function c511000253.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsControlerCanBeChanged() end
	e:GetHandler():RegisterFlagEffect(511000253,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,e:GetHandler(),1,0,0)
end
function c511000253.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and not Duel.GetControl(c,1-tp,PHASE_END,1) then
		if not c:IsImmuneToEffect(e) and c:IsAbleToChangeControler() then
			Duel.Destroy(c,REASON_EFFECT)
		end
	end
end
function c511000253.furycon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(511000253)~=0
end
function c511000253.furytg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c511000253.furyop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end

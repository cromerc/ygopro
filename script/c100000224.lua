--スカブ・スカーナイト
function c100000224.initial_effect(c)
	c:SetUniqueOnField(1,0,100000224)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--selfdes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetCondition(c100000224.sdcon)
	c:RegisterEffect(e2)
	--must attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_MUST_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e3)	
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_MUST_BE_ATTACKED)
	e4:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e4)
	--
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_BATTLED)
	e5:SetCondition(c100000224.condition)
	e5:SetOperation(c100000224.operation)
	c:RegisterEffect(e5)	
	local e6=Effect.CreateEffect(c)		
	e1:SetCategory(CATEGORY_CONTROL)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetRange(LOCATION_MZONE)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetCountLimit(1)
	e6:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e6:SetTarget(c100000224.target)
	e6:SetOperation(c100000224.activate)
	c:RegisterEffect(e6)
end
function c100000224.sdcon(e)
	return e:GetHandler():IsPosition(POS_FACEUP_DEFENSE)
end
function c100000224.condition(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetAttackTarget() and Duel.GetAttackTarget()==e:GetHandler()) or Duel.GetAttacker()==e:GetHandler()
end
function c100000224.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=e:GetHandler():GetBattleTarget()
	tg:RegisterFlagEffect(100000224,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1) 
end
function c100000224.cfilter(c)
	return c:GetFlagEffect(100000224)~=0 and c:IsControlerCanBeChanged()
end
function c100000224.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c100000224.cfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000224.cfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c100000224.cfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c100000224.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp)
	end
end

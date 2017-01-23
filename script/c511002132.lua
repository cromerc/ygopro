--Panic Burial
function c511002132.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511002132.target)
	e1:SetOperation(c511002132.activate)
	c:RegisterEffect(e1)
	if not c511002132.global_check then
		c511002132.global_check=true
		c511002132[0]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_TO_GRAVE)
		ge1:SetOperation(c511002132.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002132.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002132.filter(c)
	return c:IsFaceup() and c:GetAttack()>0
end
function c511002132.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511002132.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002132.filter,tp,0,LOCATION_MZONE,1,nil) 
		and c511002132[0]>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511002132.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,c511002132[0]*100)
end
function c511002132.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local dam=Duel.Damage(1-tp,c511002132[0]*100,REASON_EFFECT)
	if dam>0 and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-dam)
		tc:RegisterEffect(e1)
	end
end
function c511002132.checkop(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(Card.IsType,nil,TYPE_MONSTER)
	c511002132[0]=c511002132[0]+ct
end
function c511002132.clear(e,tp,eg,ep,ev,re,r,rp)
	c511002132[0]=0
end

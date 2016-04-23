--破滅の紋章
function c100000219.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c100000219.target)
	e1:SetOperation(c100000219.operation)
	c:RegisterEffect(e1)
	--equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c100000219.eqlimit)
	c:RegisterEffect(e2)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTarget(c100000219.damtg)
	e4:SetOperation(c100000219.damop)
	c:RegisterEffect(e4)
end
function c100000219.eqlimit(e,c)
	local code=c:GetCode()
	return c:IsSetCard(0x76) or code==(2407234 or 47387961)
end
function c100000219.filter(c)
	local code=c:GetCode()
	return c:IsFaceup() and (c:IsSetCard(0x76) or code==(2407234 or 47387961))
end
function c100000219.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(c100000219.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c100000219.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c100000219.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c100000219.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,LOCATION_MZONE)>0 end
	local dam=Duel.GetMatchingGroupCount(Card.IsFaceup,e:GetHandlerPlayer(),LOCATION_MZONE,LOCATION_MZONE,nil)*300
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,dam)
end
function c100000219.damop(e,tp,eg,ep,ev,re,r,rp)
	local dam=Duel.GetMatchingGroupCount(Card.IsFaceup,e:GetHandlerPlayer(),LOCATION_MZONE,LOCATION_MZONE,nil)*300
	Duel.Damage(tp,dam,REASON_EFFECT)
	Duel.Damage(1-tp,dam,REASON_EFFECT)
end

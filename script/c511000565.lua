--Dark Magician Girl (DM)
--Scripted by edo9300
function c511000565.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c511000565.val)
	c:RegisterEffect(e1)
	--add to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51100567,5))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1,511000565)
	e2:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e2:SetCondition(c511000565.con)
	e2:SetTarget(c511000565.thtg)
	e2:SetOperation(c511000565.thop)
	c:RegisterEffect(e2)
	if not c511000565.global_check then
		c511000565.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511000565.chk)
		Duel.RegisterEffect(ge1,0)
	end
end
c511000565.dm=true
function c511000565.chk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,300)
	Duel.CreateToken(1-tp,300)
end
function c511000565.val(e,c)
	return Duel.GetMatchingGroupCount(c511000565.filter,c:GetControler(),LOCATION_GRAVE,LOCATION_GRAVE,nil)*300
end
function c511000565.filter(c)
	local code=c:GetCode()
	return code==46986414 or code==30208479
end
function c511000565.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(300)>0
end
function c511000565.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)
	local dc=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if chk==0 then return dc>=ct and ct>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511000565.thop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)
	Duel.ConfirmDecktop(tp,ct)
	local g=Duel.GetDecktopGroup(tp,ct)
	g=g:Filter(Card.IsAbleToHand,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:Select(tp,1,1,nil)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,sg)
	Duel.ShuffleDeck(tp)
end

--CNo.65 裁断魔王ジャッジ・デビル
function c511010165.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),3,3)
	c:EnableReviveLimit()
	--Rank Up Check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511010165.rankupregcon)
	e1:SetOperation(c511010165.rankupregop)
	c:RegisterEffect(e1)
	--addown
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511010165,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c511010165.cost)
	e2:SetTarget(c511010165.target)
	e2:SetOperation(c511010165.operation)
	c:RegisterEffect(e2)
	--battle indestructable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(c511010165.indes)
	c:RegisterEffect(e6)
	if not c511010165.global_check then
		c511010165.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010165.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010165.xyz_number=65
function c511010165.rumfilter(c)
	return c:IsCode(3790062) and not c:IsPreviousLocation(LOCATION_OVERLAY)
end
function c511010165.rankupregcon(e,tp,eg,ep,ev,re,r,rp)
		local rc=re:GetHandler()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ) and (rc:IsSetCard(0x95) or rc:IsCode(100000581) or rc:IsCode(111011002) or rc:IsCode(511000580) or rc:IsCode(511002068) or rc:IsCode(511002164) or rc:IsCode(93238626)) and e:GetHandler():GetMaterial():IsExists(c511010165.rumfilter,1,nil)
end
function c511010165.rankupregop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
		--act limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_TRIGGER)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
end
function c511010165.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010165.filter(c)
	return c:IsFaceup()
end
function c511010165.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c511010165.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511010165.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511010165.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511010165.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
	local choice=Duel.SelectOption(tp,aux.Stringid(511010165,1),aux.Stringid(511010165,0))
	
	if choice>0 then 
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetValue(-1000)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
	else
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-1000)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
	end
end
function c511010165.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,49195710)
	Duel.CreateToken(1-tp,49195710)
end
function c511010165.indes(e,c)
return not c:IsSetCard(0x48)
end
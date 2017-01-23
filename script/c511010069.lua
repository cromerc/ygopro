--No.69 紋章神コート・オブ・アームズ (Anime)
function c511010069.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,3)
	c:EnableReviveLimit()
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTarget(c511010069.distg)
	c:RegisterEffect(e1)
	--copy	
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_MZONE)	
	e2:SetOperation(c511010069.operation)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511010069,0))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetCondition(c511010069.descon)
	e4:SetCost(c511010069.descost)
	e4:SetTarget(c511010069.destg)
	e4:SetOperation(c511010069.desop)
	c:RegisterEffect(e4)
	--battle indestructable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(c511010069.indes)
	c:RegisterEffect(e6)
	if not c511010069.global_check then
		c511010069.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010069.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010069.xyz_number=69
function c511010069.distg(e,c)
	return c~=e:GetHandler()
end
function c511010069.copfilter(c)
	return c:IsFaceup() and c:IsStatus(STATUS_DISABLED)
end
function c511010069.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local wg=Duel.GetMatchingGroup(c511010069.copfilter,tp,LOCATION_MZONE,LOCATION_MZONE,c)
	local wbc=wg:GetFirst()
	while wbc do
		local code=wbc:GetOriginalCode()
		if c:IsFaceup() and c:GetFlagEffect(code)==0 then
			c:CopyEffect(code,RESET_EVENT+0x1ff0000+EVENT_CHAINING,1)
			c:RegisterFlagEffect(code,RESET_EVENT+0x1ff0000+EVENT_CHAINING,0,1) 	
		end	
		wbc=wg:GetNext()
	end
end
function c511010069.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511010069.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010069.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511010069.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c511010069.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,2407234)
	Duel.CreateToken(1-tp,2407234)
end
function c511010069.indes(e,c)
return not c:IsSetCard(0x48)
end
--Neo Galaxy-Eyes Cipher Dragon
function c511009136.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,9,3)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetDescription(aux.Stringid(511009136,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511009136.condition)
	e1:SetCost(c511009136.cost)
	e1:SetTarget(c511009136.target)
	e1:SetOperation(c511009136.operation)
	c:RegisterEffect(e1)
	
	
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c511009136.valcheck)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	
	--return control
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetCondition(c511009136.ctcon)
	e4:SetTarget(c511009136.cttg)
	e4:SetOperation(c511009136.ctop)
	c:RegisterEffect(e4)
	
	local e5=e2:Clone()
	e5:SetLabelObject(e4)
	c:RegisterEffect(e5)
end
function c511009136.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ and e:GetLabel()==1 and e:GetHandler():GetOverlayCount()>0
end
function c511009136.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	local g=e:GetHandler():GetOverlayGroup()
	Duel.SendtoGrave(g,REASON_COST)	
end
function c511009136.filter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged()
end
function c511009136.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511009136.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,1,1-tp,LOCATION_MZONE)
end
function c511009136.operation(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectMatchingCard(tp,c511009136.filter,tp,0,LOCATION_MZONE,ft,ft,nil)
	local tc=g:GetFirst()
	while tc do
		  if Duel.GetControl(tc,tp) then
		  local e1=Effect.CreateEffect(c)
		  e1:SetType(EFFECT_TYPE_SINGLE)
		  e1:SetCode(EFFECT_DISABLE)
		  e1:SetReset(RESET_EVENT+0x1fe0000)
		  tc:RegisterEffect(e1)
		  local e2=e1:Clone()
		  e2:SetCode(EFFECT_DISABLE_EFFECT)
		  tc:RegisterEffect(e2)
		  local e3=e2:Clone()
		  e3:SetCode(EFFECT_SET_ATTACK_FINAL)
		  e3:SetValue(c:GetAttack())
		  tc:RegisterEffect(e3)
		  end
		  local e4=Effect.CreateEffect(c)
		  e4:SetType(EFFECT_TYPE_SINGLE)
		  e4:SetCode(EFFECT_CHANGE_CODE)
		  e4:SetReset(RESET_EVENT+0x1fe0000)
		  e4:SetValue(511009136)
		  tc:RegisterEffect(e4)
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_SINGLE)
		e5:SetCode(EFFECT_CANNOT_ATTACK)
		e5:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e5)
		tc:CreateRelation(c,RESET_EVENT+0x1fe0000) 
		tc=g:GetNext()
	end
end

function c511009136.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsCode,1,nil,18963306) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end


----return control
function c511009136.ctcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP) and c:GetLocation()~=LOCATION_DECK and e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ and e:GetLabel()==1
end
function c511009136.ctfilter(c,rc)
	return c:GetControler()~=c:GetOwner() and c:IsRelateToCard(rc)
end
function c511009136.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009136.ctfilter,tp,LOCATION_MZONE,0,1,nil,e:GetHandler()) end
end
function c511009136.ctop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511009136.ctfilter,tp,LOCATION_MZONE,0,nil,e:GetHandler())
	local tc=g:GetFirst()
	while tc do
		if not tc:IsImmuneToEffect(e) then
			tc:ResetEffect(EFFECT_SET_CONTROL,RESET_CODE)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_CONTROL)
			e1:SetValue(tc:GetOwner())
			e1:SetReset(RESET_EVENT+0xec0000)
			tc:RegisterEffect(e1)
		end
		tc=g:GetNext()
	end
end

--Kragen Spawn
function c511001337.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER),4,2)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetTarget(c511001337.destg)
	e1:SetOperation(c511001337.desop)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001337,1))
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCondition(c511001337.sumcon)
	e2:SetTarget(c511001337.sumtg)
	e2:SetOperation(c511001337.sumop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetOperation(c511001337.op)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
function c511001337.desfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER) and c:IsDestructable()
end
function c511001337.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511001337.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001337.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511001337.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,g:GetFirst():GetControler(),0)
end
function c511001337.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local atk=tc:GetAttack()
		if Duel.Destroy(tc,REASON_EFFECT)>0 then
			Duel.BreakEffect()
			Duel.Damage(tc:GetControler(),atk,REASON_EFFECT)
		end
	end
end
function c511001337.op(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetOverlayGroup()
	if g:GetCount()==0 then return end
	g:KeepAlive()
	e:GetLabelObject():SetLabelObject(g)
end
function c511001337.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and (c:IsCode(511001336) or c:IsCode(511001337))
end
function c511001337.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c511001337.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetLabelObject()
	local ct=g:GetCount()
	if chk==0 then return ct>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>ct-1 
		and Duel.IsExistingMatchingCard(c511001337.spfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,ct,e:GetHandler(),e,tp) end
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ct,tp,nil)
end
function c511001337.sumop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject():Filter(Card.IsRelateToEffect,nil,e)
	local ct=g:GetCount()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=ct-1 or ct<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local sp=Duel.SelectMatchingCard(tp,c511001337.spfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,ct,ct,e:GetHandler(),e,tp)
	local tc=sp:GetFirst()
	local at=g:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		Duel.Overlay(tc,Group.FromCards(at))
		tc=sp:GetNext()
		at=g:GetNext()
	end
	Duel.SpecialSummonComplete()
end

--The Phantom Knights of Break Sword
function c511001051.initial_effect(c)
	local g=Group.CreateGroup()
	g:KeepAlive()
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),3,2)
	c:EnableReviveLimit()
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001051,1))
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c511001051.sumcon)
	e1:SetTarget(c511001051.sumtg)
	e1:SetOperation(c511001051.sumop)
	c:RegisterEffect(e1)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetOperation(c511001051.op)
	e4:SetLabelObject(e1)
	c:RegisterEffect(e4)
	local e2=e1:Clone()
	e2:SetCode(EVENT_REMOVE)
	e2:SetLabelObject(e1)
	e2:SetTarget(c511001051.sumtg2)
	e2:SetOperation(c511001051.sumop2)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e3)
end
function c511001051.op(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetOverlayGroup()
	if g:GetCount()==0 then return end
	g:KeepAlive()
	e:GetLabelObject():SetLabelObject(g)
end
function c511001051.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c511001051.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001051.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetLabelObject()
	g=g:Filter(c511001051.filter,nil,e,tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if chk==0 then return g:GetCount()>0 and ft>g:GetCount()-1 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),tp,nil)
end
function c511001051.sumop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	g=g:Filter(c511001051.filter,nil,e,tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if ft<=g:GetCount()-1 then return end
	local tc=g:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(4)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
end
function c511001051.sumtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetLabelObject():GetLabelObject()
	g=g:Filter(c511001051.filter,nil,e,tp)
	if chk==0 then return g:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>g:GetCount()-1 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),tp,nil)
end
function c511001051.sumop2(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject():GetLabelObject()
	g=g:Filter(c511001051.filter,nil,e,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=g:GetCount()-1 then return end
	local tc=g:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(4)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
end

--Divine Spark Dragon Stardusr
function c511000774.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsType,TYPE_SYNCHRO),aux.NonTuner(Card.IsType,TYPE_SYNCHRO),2)
	c:EnableReviveLimit()
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511000774.destg)
	e1:SetValue(c511000774.value)
	e1:SetOperation(c511000774.desop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(511000774)
	e2:SetLabelObject(e1)
	e2:SetCondition(c511000774.con)
	e2:SetTarget(c511000774.tg)
	e2:SetOperation(c511000774.op)
	c:RegisterEffect(e2)
	--sp summon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(c511000774.spcost)
	e3:SetTarget(c511000774.sptg)
	e3:SetOperation(c511000774.spop)
	c:RegisterEffect(e3)
end
function c511000774.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(Card.IsControler,nil,tp)
	if chk==0 then
		return Duel.GetFlagEffect(tp,511000774)==0 and g:GetCount()>0
	end
	e:SetLabel(g:GetCount())
	return Duel.SelectYesNo(tp,aux.Stringid(511000774,0))
end
function c511000774.value(e,c)
	return c:IsLocation(LOCATION_ONFIELD) and c:IsControler(e:GetHandlerPlayer())
end
function c511000774.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RegisterFlagEffect(tp,511000774,RESET_PHASE+PHASE_END,0,1)
	Duel.RaiseEvent(e:GetHandler(),511000774,e,0,0,tp,0)
end
function c511000774.con(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and e:GetLabelObject():GetLabel()>0
end
function c511000774.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
end
function c511000774.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetLabelObject():GetLabel(),nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
	e:GetLabelObject():SetLabel(0)
end
function c511000774.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c511000774.filter(c,e,tp)
	return c:IsSetCard(0xa3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000774.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c511000774.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511000774.filter,tp,LOCATION_GRAVE,0,1,e:GetHandler(),e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511000774.filter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler(),e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511000774.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end

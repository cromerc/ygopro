--真閃珖竜 スターダスト・クロニクル
function c511001658.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsType,TYPE_SYNCHRO),aux.NonTuner(Card.IsType,TYPE_SYNCHRO),1)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetLabel(0)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c511001658.valcheck)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--leave replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EFFECT_SEND_REPLACE)
	e3:SetTarget(c511001658.reptg)
	e3:SetLabelObject(e1)
	c:RegisterEffect(e3)
	--reset
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ADJUST)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_MZONE)
	e4:SetOperation(c511001658.reset)
	e4:SetLabelObject(e1)
	c:RegisterEffect(e4)
	--Special Summon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(35952884,1))
	e5:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetCondition(c511001658.sumcon)
	e5:SetTarget(c511001658.sumtg)
	e5:SetOperation(c511001658.sumop)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e6)
	local e7=e5:Clone()
	e7:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e7)
end
function c511001658.valcheck(e,c)
	local ct=c:GetMaterialCount()
	e:GetLabelObject():SetLabel(ct)
end
function c511001658.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ct=e:GetLabelObject():GetLabel()
	if chk==0 then return ct>0 end
	c:SetTurnCounter(ct-1)
	e:GetLabelObject():SetLabel(ct-1)
	return true
end
function c511001658.reset(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ct=c:GetMaterialCount()
	c:SetTurnCounter(ct)
	e:GetLabelObject():SetLabel(ct)
end
function c511001658.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c511001658.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,nil)
end
function c511001658.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.CreateToken(tp,83994433)
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end

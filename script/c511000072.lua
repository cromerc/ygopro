--T.G. Cyber Magician (TF5)
function c511000072.initial_effect(c)
	--synchro limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetValue(c511000072.synlimit)
	c:RegisterEffect(e1)
	--synchro custom
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SYNCHRO_MATERIAL_CUSTOM)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetTarget(c511000072.syntg)
	e2:SetValue(1)
	e2:SetOperation(c511000072.synop)
	c:RegisterEffect(e2)
	--Type Machine
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_ADD_RACE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(RACE_MACHINE)
	c:RegisterEffect(e3)
	--Add to hand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000072,0))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetCondition(c511000072.scon)
	e4:SetTarget(c511000072.stg)
	e4:SetOperation(c511000072.sop)
	c:RegisterEffect(e4)
end
function c511000072.synlimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x27)
end
c511000072.tuner_filter=aux.FALSE
function c511000072.synfilter(c,syncard,tuner,f,lv)
	return c:IsCanBeSynchroMaterial(syncard,tuner) and (f==nil or f(c)) and c:GetLevel()==lv
end
function c511000072.syntg(e,syncard,f,minc)
	local c=e:GetHandler()
	if minc>1 then return false end
	local lv=syncard:GetLevel()-c:GetLevel()
	if lv<=0 then return false end
	return Duel.IsExistingMatchingCard(c511000072.synfilter,syncard:GetControler(),LOCATION_HAND,0,1,nil,syncard,c,f,lv)
end
function c511000072.synop(e,tp,eg,ep,ev,re,r,rp,syncard,f,minc)
	local c=e:GetHandler()
	local lv=syncard:GetLevel()-c:GetLevel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c511000072.synfilter,tp,LOCATION_HAND,0,1,1,nil,syncard,c,f,lv)
	Duel.SetSynchroMaterial(g)
end
function c511000072.scon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) and e:GetHandler():IsReason(REASON_DESTROY)
end
function c511000072.sfilter(c)
	return c:IsCode(64910482) and c:IsAbleToHand()
end
function c511000072.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000072.sfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511000072.sop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511000072.sfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

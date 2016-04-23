--Ｖ・ＨＥＲＯ ミニマム・レイ
function c100000505.initial_effect(c)	
	--send 
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000505,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c100000505.recon)
	e1:SetTarget(c100000505.rectg)
	e1:SetOperation(c100000505.recop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCost(c100000505.cost)
	e2:SetOperation(c100000505.spop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(100000505,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c100000505.descon)
	e3:SetTarget(c100000505.destg)
	e3:SetOperation(c100000505.desop)
	c:RegisterEffect(e3)
end
function c100000505.recon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c100000505.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and c:GetLocation()==LOCATION_GRAVE end
end
function c100000505.recop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetLocation()~=LOCATION_GRAVE then return false end
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	c:RegisterFlagEffect(100000501,RESET_EVENT+0x1fe0000,0,1)
end

function c100000505.costfilter(c)
	return c:IsSetCard(0x5008)
end
function c100000505.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c100000505.costfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c100000505.costfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c100000505.spop(e,tp,eg,ep,ev,re,r,rp,c)	
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
end

function c100000505.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetPreviousLocation()==LOCATION_SZONE
end
function c100000505.desfilter(c)
	return c:IsDestructable() and c:IsType(TYPE_MONSTER)
end
function c100000505.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c100000505.desfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c100000505.desfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c100000505.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
--TG ハルバード・キャノン
function c513000014.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsType,TYPE_SYNCHRO),aux.NonTuner(Card.IsType,TYPE_SYNCHRO),2)
	c:EnableReviveLimit()
	--register
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c513000014.regcon)
	e1:SetOperation(c513000014.regop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c513000014.valcheck)
	e2:SetLabelObject(e2)
	c:RegisterEffect(e2)
	--Special Summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(35952884,1))
	e3:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c513000014.spcon)
	e3:SetTarget(c513000014.sptg)
	e3:SetOperation(c513000014.spop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e5)
	--negate activate
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(2061963,0))
	e6:SetCategory(CATEGORY_DISABLE)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EVENT_CHAINING)
	e6:SetCondition(c513000014.negcon)
	e6:SetTarget(c513000014.negtg)
	e6:SetOperation(c513000014.negop)
	c:RegisterEffect(e6)
end
function c513000014.valcheck(e,c)
	local g=c:GetMaterial()
	local ct=g:GetCount()
	e:GetLabelObject():SetLabel(ct)
end
function c513000014.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO and e:GetLabel()>0
end
function c513000014.chkfilter(c,label)
	return c:GetFlagEffect(label)>0
end
function c513000014.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=e:GetLabel()
	local label=5130014
	while Duel.IsExistingMatchingCard(c513000014.chkfilter,tp,LOCATION_MZONE,0,1,nil,label) do
		label=label+1
	end
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetDescription(aux.Stringid(97836203,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCountLimit(ct,label)
	e1:SetCondition(c513000014.discon)
	e1:SetTarget(c513000014.distg)
	e1:SetOperation(c513000014.disop)
	e1:SetReset(RESET_EVENT+0x0ff0000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(97836203,1))
	e2:SetCode(EVENT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetDescription(aux.Stringid(97836203,2))
	e3:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e3)
	c:RegisterFlagEffect(51300014,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c513000014.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0
end
function c513000014.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c513000014.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
function c513000014.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c513000014.filter(c,e,tp)
	return c:IsCode(51447164) and c:IsCanBeSpecialSummoned(e,0,tp,false,true)
end
function c513000014.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c513000014.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c513000014.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c513000014.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,true,POS_FACEUP)
	end
end
function c513000014.negcon(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.GetChainInfo(ev-1,CHAININFO_TRIGGERING_EFFECT):IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	if not re:IsActiveType(TYPE_MONSTER) or ep==tp or e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) 
		or not Duel.IsChainDisablable(ev) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	if ex and tg~=nil and tc+tg:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)-tg:GetCount()==1 then
		return true
	end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TOHAND)
	if ex and tg~=nil and tc+tg:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)-tg:GetCount()==1 then
		return true
	end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_REMOVE)
	if ex and tg~=nil and tc+tg:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)-tg:GetCount()==1 then
		return true
	end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TODECK)
	if ex and tg~=nil and tc+tg:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)-tg:GetCount()==1 then
		return true
	end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_RELEASE)
	if ex and tg~=nil and tc+tg:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)-tg:GetCount()==1 then
		return true
	end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TOGRAVE)
	if ex and tg~=nil and tc+tg:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)-tg:GetCount()==1 then
		return true
	end
	return false
end
function c513000014.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c513000014.negop(e,tp,eg,ep,ev,re,r,rp)
	local tc=re:GetHandler()
	if Duel.NegateEffect(ev) and tc:IsRelateToEffect(re) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-800)
		tc:RegisterEffect(e1)
	end
end

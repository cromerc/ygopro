--Gladiator Beast Andabatae
function c511009300.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,7573135,aux.FilterBoolFunction(Card.IsFusionSetCard,0x19),2,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511009300.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(27346636,1))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c511009300.sprcon)
	e2:SetOperation(c511009300.sprop)
	c:RegisterEffect(e2)
	--spsummon when summoned
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(7573135,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetTarget(c511009300.hsptg)
	e3:SetOperation(c511009300.hspop)
	c:RegisterEffect(e3)
	
	--special summon after battle
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(48156348,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c511009300.spcon)
	e4:SetCost(c511009300.spcost)
	e4:SetTarget(c511009300.sptg)
	e4:SetOperation(c511009300.spop)
	c:RegisterEffect(e4)
	--gain atk when a GB is shuffled
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(36378213,0))
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCategory(CATEGORY_ATKCHANGE)
	e5:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e5:SetCode(EVENT_TO_DECK)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c511009300.atkcon)
	e5:SetOperation(c511009300.atkop)
	c:RegisterEffect(e5)
end
function c511009300.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c511009300.spfilter1(c,tp)
	return c:IsFusionCode(7573135) and c:IsAbleToDeckOrExtraAsCost() and c:IsCanBeFusionMaterial(nil,true)
		and Duel.IsExistingMatchingCard(c511009300.spfilter2,tp,LOCATION_MZONE,0,2,c)
end
function c511009300.spfilter2(c)
	return c:IsFusionSetCard(0x19) and c:IsCanBeFusionMaterial() and c:IsAbleToDeckOrExtraAsCost()
end
function c511009300.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3
		and Duel.IsExistingMatchingCard(c511009300.spfilter1,tp,LOCATION_ONFIELD,0,1,nil,tp)
end
function c511009300.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(27346636,2))
	local g1=Duel.SelectMatchingCard(tp,c511009300.spfilter1,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(27346636,3))
	local g2=Duel.SelectMatchingCard(tp,c511009300.spfilter2,tp,LOCATION_MZONE,0,2,2,g1:GetFirst())
	g1:Merge(g2)
	local tc=g1:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g1:GetNext()
	end
	Duel.SendtoDeck(g1,nil,2,REASON_COST)
end




function c511009300.hspfilter(c,e,tp)
	return c:IsSetCard(0x19) and not c:IsCode(511009300) and c:IsCanBeSpecialSummoned(e,113,tp,true,false)
end
function c511009300.hsptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511009300.hspfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511009300.hspop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511009300.hspfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		tc:RegisterFlagEffect(511009300,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		tc:RegisterFlagEffect(tc:GetOriginalCode(),RESET_EVENT+0x1ff0000,0,0)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_DAMAGE_STEP_END)
		e1:SetCountLimit(1)
		e1:SetLabelObject(tc)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCondition(c511009300.retcon)
		e1:SetOperation(c511009300.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511009300.retcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return tc:GetFlagEffect(511009300)>0 and tc:IsRelateToBattle() and tc:IsFaceup()
end
function c511009300.retop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
end



function c511009300.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattledGroupCount()>0
end
function c511009300.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToExtraAsCost() end
	Duel.SendtoDeck(c,nil,0,REASON_COST)
end
function c511009300.filter(c,e,tp)
	return c:IsSetCard(0x19) and c:IsCanBeSpecialSummoned(e,120,tp,false,false)
end
function c511009300.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511009300.filter,tp,LOCATION_DECK,0,2,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c511009300.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	local g=Duel.GetMatchingGroup(c511009300.filter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,2,2,nil)
		local tc=sg:GetFirst()
		Duel.SpecialSummonStep(tc,120,tp,tp,false,false,POS_FACEUP)
		tc:RegisterFlagEffect(tc:GetOriginalCode(),RESET_EVENT+0x1ff0000,0,0)
		tc=sg:GetNext()
		Duel.SpecialSummonStep(tc,120,tp,tp,false,false,POS_FACEUP)
		tc:RegisterFlagEffect(tc:GetOriginalCode(),RESET_EVENT+0x1ff0000,0,0)
		Duel.SpecialSummonComplete()
	end
end
function c511009300.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetCount()==1 and eg:GetFirst():IsSetCard(0x19)
end
function c511009300.atkfilter(c,e,tp)
	return c:GetPreviousControler()==tp and c:IsSetCard(0x19) and c:GetAttack()>0
end
function c511009300.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler()
	local g=eg:Filter(c511009300.atkfilter,nil,e,tp)
	if not g:GetCount()==1 then return end
	local atk=g:GetSum(Card.GetAttack)
	local e1=Effect.CreateEffect(tc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	e1:SetValue(atk)
	tc:RegisterEffect(e1)
end

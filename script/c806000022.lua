--武神－ミカズチ
function c806000022.initial_effect(c)
	c:SetUniqueOnField(1,0,806000022)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c806000022.spcon)
	e1:SetTarget(c806000022.sptg)
	e1:SetOperation(c806000022.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetCountLimit(1)
	e3:SetCondition(c806000022.thcon)
	e3:SetTarget(c806000022.thtg)
	e3:SetOperation(c806000022.thop)
	c:RegisterEffect(e3)
	if c806000022.counter==nil then
		c806000022.counter=true
		c806000022[0]=0
		c806000022[1]=0
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e4:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		e4:SetOperation(c806000022.resetcount)
		Duel.RegisterEffect(e4,0)
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e5:SetCode(EVENT_TO_GRAVE)
		e5:SetOperation(c806000022.addcount)
		Duel.RegisterEffect(e5,0)
	end
end
function c806000022.resetcount(e,tp,eg,ep,ev,re,r,rp)
	c806000022[0]=0
	c806000022[1]=0
end
function c806000022.addcount(e,tp,eg,ep,ev,re,r,rp)
	local c=eg:GetFirst()
	while c~=nil do
		local p=c:GetPreviousControler()
		if c:IsSetCard(0x88) and c:IsType(TYPE_MONSTER) and c:IsPreviousLocation(LOCATION_HAND) 
		then c806000022[p]=c806000022[p]+1 end
		c=eg:GetNext()
	end
end
function c806000022.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsLocation(LOCATION_GRAVE)
	 and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousControler()==tp
	 and c:IsSetCard(0x88) and c:IsRace(RACE_BEASTWARRIOR)
end
function c806000022.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c806000022.cfilter,1,nil,tp)
end
function c806000022.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c806000022.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c806000022.thcon(e,tp,eg,ep,ev,re,r,rp)
	return c806000022[tp]>0
end
function c806000022.filter(c)
	return c:IsSetCard(0x88) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c806000022.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c806000022.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c806000022.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c806000022.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
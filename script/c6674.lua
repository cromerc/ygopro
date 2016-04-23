--Scripted by Eerie Code
--Greydle Parasite
function c6674.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c0)
	e1:SetTarget(c6674.target)
	c:RegisterEffect(e1)
	--Sp. Summon (you)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6674,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,6674)
	e2:SetCondition(c6674.spcon1)
	e2:SetTarget(c6674.sptg1)
	e2:SetOperation(c6674.spop1)
	c:RegisterEffect(e2)
	--Sp. Summon (opponent)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(6674,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,6675)
	e3:SetCondition(c6674.spcon2)
	e3:SetTarget(c6674.sptg2)
	e3:SetOperation(c6674.spop2)
	c:RegisterEffect(e3)
end

function c6674.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local b1=c6674.spcon1(e,tp,eg,ep,ev,re,r,rp) and c6674.sptg1(e,tp,eg,ep,ev,re,r,rp,0)
	local b2=c6674.spcon2(e,tp,eg,ep,ev,re,r,rp) and c6674.sptg2(e,tp,eg,ep,ev,re,r,rp,0,nil)
	if (b1 or b2) and Duel.SelectYesNo(tp,aux.Stringid(6674,0)) then
		local opt=0
		if b1 and b2 then
			opt=Duel.SelectOption(tp,aux.Stringid(6674,1),aux.Stringid(6674,2))
		elseif b1 then
			opt=Duel.SelectOption(tp,aux.Stringid(6674,1))
		else
			opt=Duel.SelectOption(tp,aux.Stringid(6674,2))+1
		end
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		if opt==0 then
			e:SetProperty(0)
			e:SetOperation(c6674.spop1)
			c6674.sptg1(e,tp,eg,ep,ev,re,r,rp,1)
		else
			e:SetProperty(EFFECT_FLAG_CARD_TARGET)
			e:SetOperation(c6674.spop2)
			c6674.sptg2(e,tp,eg,ep,ev,re,r,rp,1,nil)
		end
	else
		e:SetCategory(0)
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end

function c6674.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c6674.spfil1(c,e,tp)
	return c:IsSetCard(0xd1) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c6674.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c6674.spfil1,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c6674.spop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c6674.spfil1,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then 
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK) 
	end
end

function c6674.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(tp) and Duel.GetAttackTarget()==nil and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)==0
end
function c6674.spfil2(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp)
end
function c6674.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c6674.spfil2(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c6674.spfil2,tp,0,LOCATION_GRAVE,1,nil,e,tp) end
	local g=Duel.SelectTarget(tp,c6674.spfil2,tp,0,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c6674.spop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,1-tp,false,false,POS_FACEUP)
	end
end
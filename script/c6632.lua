--Scripted by Eerie Code
--Greydle Slime
function c6632.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6632,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,6632)
	e1:SetTarget(c6632.sptg)
	e1:SetOperation(c6632.spop) 
	c:RegisterEffect(e1)
	--Special Summon from Grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6632,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCondition(c6632.spcon2)
	e2:SetTarget(c6632.sptg2)
	e2:SetOperation(c6632.spop2)
	c:RegisterEffect(e2)
end

function c6632.desfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xd1) and c:IsDestructable()
end
function c6632.desfilter2(c,e)
	return c6632.desfilter(c) and c:IsCanBeEffectTarget(e)
end
function c6632.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c6632.desfilter(chkc) end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ct=-ft+1
	if chk==0 then return ct<=2 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingTarget(c6632.desfilter,tp,LOCATION_ONFIELD,0,2,nil)
		and (ct<=0 or Duel.IsExistingTarget(c6632.desfilter,tp,LOCATION_MZONE,0,ct,nil)) end
	local g=nil
	if ct>0 then
		local tg=Duel.GetMatchingGroup(c6632.desfilter2,tp,LOCATION_ONFIELD,0,nil,e)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		g=tg:FilterSelect(tp,Card.IsLocation,ct,ct,nil,LOCATION_MZONE)
		if ct<2 then
			tg:Sub(g)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local g2=tg:Select(tp,2-ct,2-ct,nil)
			g:Merge(g2)
		end
		Duel.SetTargetCard(g)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		g=Duel.SelectTarget(tp,c6632.desfilter,tp,LOCATION_ONFIELD,0,2,2,nil)
	end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c6632.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if Duel.Destroy(g,REASON_EFFECT)~=0 then
		Duel.SpecialSummon(e:GetHandler(),1,tp,tp,false,false,POS_FACEUP)
	end
end

function c6632.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1
end
function c6632.spfil(c,e,tp)
	return c:IsSetCard(0xd1) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c6632.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c6632.spfil(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and
		Duel.IsExistingTarget(c6632.spfil,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c6632.spfil,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c6632.spop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENCE)
	end
end
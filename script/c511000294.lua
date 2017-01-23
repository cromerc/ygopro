--Number C1000: Numerronius
function c511000294.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,12,5)
	c:EnableReviveLimit()
	--negate and cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c511000294.negfilter)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetTarget(c511000294.negfilter)
	c:RegisterEffect(e3)
	--Destroy replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c511000294.desreptg)
	e4:SetOperation(c511000294.desrepop)
	c:RegisterEffect(e4)
	--destroy and summon C
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetDescription(aux.Stringid(511000294,2))
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetCost(c511000294.descost)
	e5:SetTarget(c511000294.destg)
	e5:SetOperation(c511000294.desop)
	c:RegisterEffect(e5)
	--destroy and summon Battle
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1)
	e6:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e6:SetTarget(c511000294.bptg)
	e6:SetOperation(c511000294.bpop)
	c:RegisterEffect(e6)
	--battle indestructable
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e7:SetValue(c511000294.indes)
	c:RegisterEffect(e7)
end
c511000294.xyz_number=1000
function c511000294.negfilter(e,c)
	return c:IsSetCard(0x1048) or c:IsSetCard(0x1073) or c:IsCode(511000296)
end
function c511000294.repfilter(c)
	return not c:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED)
end
function c511000294.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsOnField() and c:IsFaceup()
		and Duel.IsExistingMatchingCard(c511000294.repfilter,tp,LOCATION_MZONE,0,1,c) end
	if Duel.SelectYesNo(tp,aux.Stringid(511000294,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local g=Duel.SelectMatchingCard(tp,c511000294.repfilter,tp,LOCATION_MZONE,0,1,1,c)
		e:SetLabelObject(g:GetFirst())
		Duel.HintSelection(g)
		g:GetFirst():SetStatus(STATUS_DESTROY_CONFIRMED,true)
		return true
	else return false end
end
function c511000294.desrepop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	tc:SetStatus(STATUS_DESTROY_CONFIRMED,false)
	Duel.Destroy(tc,REASON_EFFECT+REASON_REPLACE)
end
function c511000294.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511000294.desfilter(c,e,tp)
	return Duel.IsExistingMatchingCard(c511000294.xyzfilter,c:GetControler(),LOCATION_EXTRA,0,1,nil,e,tp)
end
function c511000294.xyzfilter(c,e,tp)
	return (c:IsSetCard(0x1048) or c:IsSetCard(0x1073) or c:IsCode(511000296)) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511000294.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000294.desfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511000294.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511000294.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511000294.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local p=tc:GetControler()
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			Duel.BreakEffect()
			if p~=tp then
				local g2=Duel.GetFieldGroup(tp,0,LOCATION_EXTRA)
				Duel.ConfirmCards(tp,g2)
			end
			local g=Duel.SelectMatchingCard(tp,c511000294.xyzfilter,p,LOCATION_EXTRA,0,1,1,nil,e,tp)
			if g:GetCount()>0 then
				Duel.SpecialSummon(g,0,tp,p,true,false,POS_FACEUP)
			end
		end
	end
end
function c511000294.bptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c511000294.spfilter(c,e,tp,tid)
	return c:GetTurnID()==tid and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c511000294.bpop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT)
	Duel.BreakEffect()
	local tid=Duel.GetTurnCount()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	local g=Duel.GetMatchingGroup(c511000294.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,e,tp,tid)
	if g:GetCount()>ft then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		g=g:Select(tp,ft,ft,nil)
	end
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
end
function c511000294.indes(e,c)
	return not c:IsSetCard(0x48)
end

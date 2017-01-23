--Rebirth of the Seven Emperors
function c511001532.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511001532.condition)
	e1:SetCost(c511001532.cost)
	e1:SetTarget(c511001532.target)
	e1:SetOperation(c511001532.activate)
	c:RegisterEffect(e1)
end
function c511001532.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at and at:IsFaceup() and at:IsControler(tp) and at:IsType(TYPE_XYZ)
end
function c511001532.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
	
	if chk==0 then return  end
end
function c511001532.filter(c,e,tp)
	return c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetFlagEffect(511001531)>0
end
function c511001532.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local sg=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,nil,TYPE_XYZ)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return sg:GetCount()>0 and sg:FilterCount(Card.IsReleasable,nil)==sg:GetCount() and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c511001532.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil,e,tp)  end
	local ct=Duel.Release(sg,REASON_COST)
	Duel.SetTargetParam(ct+1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_REMOVED)
end
function c511001532.atfilter(c)
	local code=c:GetCode()
	local class=_G["c"..code]
	if class==nil then return false end
	local no=class.xyz_number
	return no and no>=101 and no<=107 and c:IsFaceup() and c:IsSetCard(0x1048)
end
function c511001532.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001532.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		local g=Duel.GetMatchingGroup(c511001532.atfilter,tp,LOCATION_REMOVED,0,nil)
		if g:GetCount()>0 then
			if g:GetCount()>ct then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
				g=g:Select(tp,ct,ct,nil)
			end
			Duel.Overlay(tc,g)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_TRIGGER)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
			e2:SetReset(RESET_PHASE+PHASE_BATTLE)
			e2:SetCountLimit(1)
			e2:SetOperation(c511001532.damop)
			Duel.RegisterEffect(e2,tp)
		end
	end
end
function c511001532.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511001532)
	local dam=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)*300
	Duel.Damage(tp,dam,REASON_EFFECT)
	dam=Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)*300
	Duel.Damage(1-tp,dam,REASON_EFFECT)
end

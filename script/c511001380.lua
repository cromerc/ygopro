--Explosion Fuse
function c511001380.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511001380.con)
	e1:SetTarget(c511001380.target)
	e1:SetOperation(c511001380.activate)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(c511001380.desop)
	c:RegisterEffect(e2)
end
function c511001380.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c511001380.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE) and c:GetPreviousControler()==1-tp
end
function c511001380.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001380.cfilter,1,nil,tp)
end
function c511001380.filter(c,e,tp)
	return c:IsCode(511001379) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001380.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511001380.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511001380.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001380.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if c:IsRelateToEffect(e) and tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
		Duel.Equip(tp,c,tc)
		--Add Equip limit
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511001380.eqlimit)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(aux.Stringid(511001380,0))
		e2:SetCategory(CATEGORY_DAMAGE)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e2:SetRange(LOCATION_SZONE)
		e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e2:SetCondition(c511001380.damcon)
		e2:SetTarget(c511001380.damtg)
		e2:SetOperation(c511001380.damop)
		if tp==Duel.GetTurnPlayer() then
			e2:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
		else
			e2:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,1)
		end
		c:RegisterEffect(e2)
	end
end
function c511001380.eqlimit(e,c)
	return e:GetOwner()==c
end
function c511001380.damcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c511001380.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local eq=e:GetHandler():GetEquipTarget()
	if chk==0 then return eq end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eq,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c511001380.damop(e,tp,eg,ep,ev,re,r,rp)
	local eq=e:GetHandler():GetEquipTarget()
	if not eq then return end
	if Duel.Destroy(eq,REASON_EFFECT)~=0 then
		Duel.Damage(1-tp,1000,REASON_EFFECT)
	end
end

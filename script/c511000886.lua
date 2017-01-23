--Parasite Caterpillar
function c511000886.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetOperation(c511000886.regop)
	c:RegisterEffect(e1)
end
function c511000886.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000886,0))
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(c511000886.eqcon)
	e2:SetOperation(c511000886.eqop)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	c:RegisterEffect(e2)
end
function c511000886.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==e:GetHandler()
end
function c511000886.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if not tc:IsRelateToBattle() or not c:IsRelateToBattle() then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsFacedown() then
		Duel.Destroy(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc)
	local e1=Effect.CreateEffect(tc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(c511000886.eqlimit)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(tc)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_CHANGE_RACE)
	e2:SetValue(RACE_INSECT)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(tc)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UNRELEASABLE_SUM)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(tc)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetValue(1)
	e5:SetReset(RESET_EVENT+0x1fc0000)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(tc)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_DIRECT_ATTACK)
	e6:SetRange(LOCATION_SZONE)
	e6:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e6:SetTarget(c511000886.dirtg)
	e6:SetReset(RESET_EVENT+0x1fc0000)
	c:RegisterEffect(e6)
	tc:RegisterFlagEffect(511000886,RESET_EVENT+0x1fe0000,0,1)
	c:SetTurnCounter(0)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e7:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e7:SetCountLimit(1)
	e7:SetRange(LOCATION_SZONE)
	e7:SetOperation(c511000886.desop)
	e7:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_OPPO_TURN,3)
	c:RegisterEffect(e7)
end
function c511000886.eqlimit(e,c)
	return e:GetOwner()==c
end
function c511000886.dirfilter(c)
	return c:GetFlagEffect(511000886)==0
end
function c511000886.dirtg(e,c)
	return not Duel.IsExistingMatchingCard(c511000886.dirfilter,c:GetControler(),0,LOCATION_MZONE,1,nil)
end
function c511000886.desop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()==tp then return end
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==3 then
		--destroy&sp summon
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(aux.Stringid(511000886,1))
		e2:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e2:SetRange(LOCATION_SZONE)
		e2:SetCountLimit(1)
		e2:SetCondition(c511000886.con)
		e2:SetTarget(c511000886.tg)
		e2:SetOperation(c511000886.op)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
	end
end
function c511000886.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511000886.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ec=e:GetHandler():GetEquipTarget()
	ec:CreateEffectRelation(e)
	e:SetLabelObject(ec)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,ec,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511000886.filter(c,e,tp)
	return c:IsCode(511000887) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c511000886.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local ec=e:GetLabelObject()
	if ec:IsRelateToEffect(e) and ec:IsFaceup() then
		if Duel.Destroy(ec,REASON_EFFECT)~=0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,c511000886.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
			if g:GetCount()>0 then
				Duel.SpecialSummon(g,0,tp,1-tp,true,true,POS_FACEUP)
				Duel.ShuffleDeck(tp)
			else
				local cg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
				Duel.ConfirmCards(1-tp,cg)
				Duel.ShuffleDeck(tp)
			end
		else
			Duel.Destroy(c,REASON_EFFECT)
		end
	end
end

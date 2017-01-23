--シューティング・クェーサー・ドラゴン
function c513000031.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsType,TYPE_SYNCHRO),aux.NonTuner(Card.IsType,TYPE_SYNCHRO),2)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c513000031.efilter)
	c:RegisterEffect(e1)
	--multi attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c513000031.mtcon)
	e2:SetOperation(c513000031.mtop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_MATERIAL_CHECK)
	e3:SetValue(c513000031.valcheck)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--Special Summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(35952884,1))
	e4:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e4:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetCondition(c513000031.sumcon)
	e4:SetTarget(c513000031.sumtg)
	e4:SetOperation(c513000031.sumop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e6)
	--destroy
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EVENT_DAMAGE_STEP_END)
	e7:SetRange(LOCATION_MZONE)
	e7:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e7:SetCondition(c513000031.descon)
	e7:SetOperation(c513000031.desop)
	c:RegisterEffect(e7)
	--reduce
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetCode(EFFECT_CHANGE_DAMAGE)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e8:SetRange(LOCATION_MZONE)
	e8:SetTargetRange(1,0)
	e8:SetCondition(c513000031.damcon)
	e8:SetValue(c513000031.damval)
	c:RegisterEffect(e8)
	local e9=e8:Clone()
	e9:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	c:RegisterEffect(e9)
end
function c513000031.valcheck(e,c)
	local g=c:GetMaterial()
	local ct=g:FilterCount(Card.IsType,nil,TYPE_SYNCHRO)
	e:GetLabelObject():SetLabel(ct)
end
function c513000031.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO and e:GetLabel()>0
end
function c513000031.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=e:GetLabel()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e1:SetValue(ct-1)
	c:RegisterEffect(e1)
end
function c513000031.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c513000031.filter(c,e,tp)
	return c:IsCode(24696097) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false)
end
function c513000031.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c513000031.sumop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c513000031.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
	if tc then
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)
		tc:CompleteProcedure()
	end	
end
function c513000031.descon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d
end
function c513000031.desfilter(c,ca)
	return not c:IsStatus(STATUS_BATTLE_DESTROYED) and (not ca or ca==c)
end
function c513000031.desop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not a:IsStatus(STATUS_BATTLE_DESTROYED) or not d:IsStatus(STATUS_BATTLE_DESTROYED) then
		local g=Group.FromCards(a,d)
		if a:IsAttackPos() and d:IsAttackPos() then
			if a:GetAttack()==d:GetAttack()  then
				g=g:Filter(c513000031.desfilter,nil,nil)
			elseif a:GetAttack()<d:GetAttack() then
				g=g:Filter(c513000031.desfilter,nil,a)
			elseif a:GetAttack()>d:GetAttack() then
				g=g:Filter(c513000031.desfilter,nil,d)
			else
				g=Group.CreateGroup()
			end
		elseif a:IsAttackPos() and d:IsDefensePos() then
			if a:GetAttack()>d:GetDefense() then
				g=g:Filter(c513000031.desfilter,nil,d)
			else
				g=Group.CreateGroup()
			end
		else
			g=Group.CreateGroup()
		end
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetReset(RESET_CHAIN)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e2:SetReset(RESET_CHAIN)
			tc:RegisterEffect(e2)
			tc:SetStatus(STATUS_BATTLE_DESTROYED,true)
			tc=g:GetNext()
		end
		Duel.Destroy(g,REASON_BATTLE)
	end
end
function c513000031.damcon(e)
	local ph=Duel.GetCurrentPhase()
	return ph>=0x08 and ph<=0x20
end
function c513000031.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 then return 0 end
	return val
end
function c513000031.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer() and re:IsActiveType(TYPE_MONSTER)
end

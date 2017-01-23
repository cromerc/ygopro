--The Winged Dragon of Ra (Anime)
--マイケル・ローレンス・ディーによってスクリプト
function c51100236.initial_effect(c)
	--Summon with 3 Tribute
	c:SetUniqueOnField(1,0,51100236)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c51100236.sumoncon)
	e1:SetOperation(c51100236.sumonop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_LIMIT_SET_PROC)
	e2:SetCondition(c51100236.setcon)
	c:RegisterEffect(e2)
	--Summon Cannot be Negated
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e3)
	--summon success
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetOperation(c51100236.sumsuc)
	c:RegisterEffect(e4)
	--release limit
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_UNRELEASABLE_SUM)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetValue(c51100236.recon)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCondition(c51100236.recon2)
	e7:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e7)
	--cannot be target
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetValue(c51100236.tgfilter)
	c:RegisterEffect(e8)
	--immune effect
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetCode(EFFECT_IMMUNE_EFFECT)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetValue(c51100236.efilter)
	c:RegisterEffect(e9)
	--indes
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e10:SetValue(1)
	c:RegisterEffect(e10)
	--ATK/DEF effects are only applied until the End Phase
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e11:SetProperty(EFFECT_FLAG_REPEAT)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCode(EVENT_PHASE+PHASE_END)
	e11:SetCountLimit(1)
	e11:SetOperation(c51100236.atkdefresetop)
	c:RegisterEffect(e11)
	--If Special Summoned: Send to previous location
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(511000235,1))
	e12:SetCategory(CATEGORY_TOGRAVE+CATEGORY_REMOVE+CATEGORY_TOHAND+CATEGORY_TODECK)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e12:SetRange(LOCATION_MZONE)
	e12:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e12:SetCountLimit(1)
	e12:SetCode(EVENT_PHASE+PHASE_END)
	e12:SetCondition(c51100236.stgcon)
	e12:SetTarget(c51100236.stgtg)
	e12:SetOperation(c51100236.stgop)
	c:RegisterEffect(e12)
	--Point-to-Point Transfer
	local e15=Effect.CreateEffect(c)
	e15:SetDescription(aux.Stringid(51100236,1))
	e15:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e15:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e15:SetCode(EVENT_SPSUMMON_SUCCESS)
	e15:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e15:SetCondition(c51100236.egpcon)
	e15:SetCost(c51100236.payatkcost)
	e15:SetOperation(c51100236.payatkop)
	c:RegisterEffect(e15)
	--negate
	local e16=Effect.CreateEffect(c)
	e16:SetDescription(aux.Stringid(51100236,6))
	e16:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e16:SetCode(EVENT_BE_BATTLE_TARGET)
	e16:SetCondition(c51100236.negcon)
	e16:SetOperation(c51100236.negop)
	c:RegisterEffect(e16)
	--Egyptian God Phoenix
	local e18=Effect.CreateEffect(c)
	e18:SetDescription(aux.Stringid(51100236,5))
	e18:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e18:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e18:SetCode(EVENT_SPSUMMON_SUCCESS)
	e18:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e18:SetCondition(c51100236.egpcon)
	e18:SetOperation(c51100236.egpop)
	c:RegisterEffect(e18)
	--[[tribute check
	local ea=Effect.CreateEffect(c)
	ea:SetType(EFFECT_TYPE_SINGLE)
	ea:SetCode(EFFECT_MATERIAL_CHECK)
	ea:SetValue(c51100236.valcheck)
	c:RegisterEffect(ea)
	--give atk effect only when summon
	local ex=Effect.CreateEffect(c)
	ex:SetType(EFFECT_TYPE_SINGLE)
	ex:SetCode(EFFECT_SUMMON_COST)
	ex:SetOperation(c51100236.facechk)
	ex:SetLabelObject(ea)
	c:RegisterEffect(ex)]]
	--chant
	local sum1=Effect.CreateEffect(c)
	sum1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	sum1:SetCode(EVENT_SUMMON_SUCCESS)
	sum1:SetOperation(c51100236.sumop)
	c:RegisterEffect(sum1)
	local sum2=sum1:Clone()
	sum2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(sum2)
	local sum3=sum1:Clone()
	sum3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(sum3)
	--redirect attack
	local red=Effect.CreateEffect(c)
	red:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	red:SetCode(EVENT_SPSUMMON_SUCCESS)
	red:SetOperation(c51100236.redatk)
	c:RegisterEffect(red)
	--De-Fusion
	if not c51100236.global_check then
		c51100236.global_check=true
		local df=Effect.CreateEffect(c)
		df:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		df:SetCode(EVENT_ADJUST)
		df:SetOperation(c51100236.dfop)
		Duel.RegisterEffect(df,0)
	end
end
function c51100236.dfop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetMatchingGroup(Card.IsCode,c:GetControler(),0xff,0xff,nil,95286165)
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(51100236)==0 then
			--Activate
			local e1=Effect.CreateEffect(tc)
			e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
			e1:SetDescription(aux.Stringid(51100236,4))
			e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE+CATEGORY_RECOVER)
			e1:SetType(EFFECT_TYPE_ACTIVATE)
			e1:SetCode(EVENT_FREE_CHAIN)
			e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetHintTiming(0,TIMING_DRAW_PHASE+TIMING_END_PHASE)
			e1:SetTarget(c51100236.tg)
			e1:SetOperation(c51100236.op)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(51100236,0,0,1) 	
		end
		tc=g:GetNext()
	end
end
function c51100236.dffilter2(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION) and (c:IsCode(10000010) or c:IsCode(511000237))
end
function c51100236.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c51100236.dffilter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c51100236.dffilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c51100236.dffilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,g:GetFirst():GetAttack())
end
function c51100236.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and tc:IsFaceup()) then return end
	local atk=tc:GetAttack()
	tc:ResetEffect(RESET_LEAVE,RESET_EVENT)
	Duel.Recover(tp,atk,REASON_EFFECT)
	tc:RegisterFlagEffect(236,RESET_EVENT+0x1fe0000,0,1)
	if Duel.GetAttacker() and Duel.GetAttacker()==tc then Duel.NegateAttack() end
	if Duel.GetCurrentChain()<=1 then return end
	for i=1,Duel.GetCurrentChain()-1 do
		local te=Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
		local g=Duel.GetChainInfo(i,CHAININFO_TARGET_CARDS)
		if te:IsHasProperty(EFFECT_FLAG_CARD_TARGET) and g:IsContains(tc) then
			local rg=Group.CreateGroup()
			rg:Merge(g)
			rg:RemoveCard(tc)
			Duel.ChangeTargetCard(i,rg)
		end
	end
end
function c51100236.sumoncon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c51100236.sumonop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c51100236.setcon(e,c)
	if not c then return true end
	return false
end
function c51100236.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(c51100236.chainlm)
end
function c51100236.chainlm(e,rp,tp)
	return e:GetHandler():IsAttribute(ATTRIBUTE_DEVINE)
end
function c51100236.recon(e,c)
	return c:GetControler()~=e:GetHandler():GetControler()
end
function c51100236.recon2(e)
	return Duel.GetTurnPlayer()~=e:GetOwnerPlayer()
end
function c51100236.efilter(e,te)
	return te:IsActiveType(TYPE_EFFECT) and te:GetOwner()~=e:GetOwner()
end
function c51100236.tgfilter(e,re)
	if not re or not re:IsActiveType(TYPE_SPELL+TYPE_TRAP) then return false end
	return re:IsHasCategory(CATEGORY_DESTROY+CATEGORY_RELEASE+CATEGORY_REMOVE+CATEGORY_TOHAND+CATEGORY_TODECK+CATEGORY_TOGRAVE)
end
function c51100236.tgg(c,card)
	return c:GetCardTarget() and c:GetCardTarget():IsContains(card)
end
function c51100236.atkdefresetop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetValue(c:GetBaseAttack())
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetValue(c:GetBaseDefense())
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
	local eqg=c:GetEquipGroup()
	local tgg=Duel.GetMatchingGroup(c51100236.tgg,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,c)
	eqg:Merge(tgg)
	if eqg:GetCount()>0 then
		Duel.Destroy(eqg,REASON_EFFECT)
	end
end
function c51100236.stgcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c51100236.stgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	if c:IsPreviousLocation(LOCATION_GRAVE) then
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,c,1,0,0)
	elseif c:IsPreviousLocation(LOCATION_DECK) then
		Duel.SetOperationInfo(0,CATEGORY_TODECK,c,1,0,0)
	elseif c:IsPreviousLocation(LOCATION_HAND) then
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,c,1,0,0)
	elseif c:IsPreviousLocation(LOCATION_REMOVED) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,c,1,0,0)
	end
end
function c51100236.stgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		if c:IsPreviousLocation(LOCATION_GRAVE) then
			Duel.SendtoGrave(c,REASON_EFFECT)
		elseif c:IsPreviousLocation(LOCATION_DECK) then
			Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
		elseif c:IsPreviousLocation(LOCATION_HAND) then
			Duel.SendtoHand(c,nil,REASON_EFFECT)
		elseif c:IsPreviousLocation(LOCATION_REMOVED) then
			Duel.Remove(c,POS_FACEUP,REASON_EFFECT)
		end
	end
end
function c51100236.valcheck(e,c)
	local g=c:GetMaterial()
	local tc=g:GetFirst()
	local atk=0
	local def=0
	while tc do
		local catk=tc:GetTextAttack()
		local cdef=tc:GetTextDefense()
		atk=atk+(catk>=0 and catk or 0)
		def=def+(cdef>=0 and cdef or 0)
		tc=g:GetNext()
	end
	if e:GetLabel()==1 then
		e:SetLabel(0)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0xff0000)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_BASE_DEFENSE)
		e2:SetValue(def)
		c:RegisterEffect(e2)
	end
end
function c51100236.facechk(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(1)
end
function c51100236.payatkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2) end
	local lp=Duel.GetLP(tp)
	e:SetLabel(lp-1)
	Duel.PayLPCost(tp,lp-1)
end
function c51100236.payatkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local lp=e:GetLabel()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(c:GetBaseAttack()+lp)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_BASE_DEFENSE)
		e2:SetValue(c:GetBaseDefense()+lp)
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_ADD_TYPE)
		e3:SetValue(TYPE_FUSION)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e3,true)
		local def=Effect.CreateEffect(c)
		def:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(def)
		local e4=Effect.CreateEffect(c)
		e4:SetDescription(aux.Stringid(2191144,0))
		e4:SetType(EFFECT_TYPE_QUICK_O)
		e4:SetCode(EVENT_FREE_CHAIN)
		e4:SetRange(LOCATION_MZONE)
		e4:SetCost(c51100236.tatkcost)
		e4:SetOperation(c51100236.tatkop)
		e4:SetLabelObject(def)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e4)
		--gain atk/def
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e5:SetCode(EVENT_RECOVER)
		e5:SetRange(LOCATION_MZONE)
		e5:SetOperation(c51100236.atkop1)
		e5:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e5)
		--gain atk/def
		local e6=Effect.CreateEffect(c)
		e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e6:SetCode(EVENT_CHAIN_END)
		e6:SetRange(LOCATION_MZONE)
		e6:SetOperation(c51100236.atkop2)
		e6:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e6)
		local e7=Effect.CreateEffect(c)
		e7:SetType(EFFECT_TYPE_FIELD)
		e7:SetRange(LOCATION_MZONE)
		e7:SetTargetRange(0,LOCATION_MZONE)
		e7:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
		e7:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
		e7:SetTarget(c51100236.valtg)
		e7:SetValue(c51100236.vala)
		e7:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e7)
		local e8=Effect.CreateEffect(c)
		e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e8:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
		e8:SetCode(EVENT_DAMAGE_STEP_END)
		e8:SetCondition(c51100236.dircon)
		e8:SetOperation(c51100236.dirop)
		e8:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e8)
		local e9=Effect.CreateEffect(c)
		e9:SetType(EFFECT_TYPE_SINGLE)
		e9:SetCode(EFFECT_EXTRA_ATTACK)
		e9:SetValue(9999)
		e9:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e9)
		local e10=Effect.CreateEffect(c)
		e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e10:SetCode(EVENT_DAMAGE_STEP_END)
		e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e10:SetCondition(c51100236.uncon)
		e10:SetOperation(c51100236.unop)
		e10:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e10)
	end
end
function c51100236.atkop1(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(ev)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e:GetHandler():RegisterEffect(e1)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetValue(ev)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e:GetHandler():RegisterEffect(e1)
	Duel.SetLP(tp,1,REASON_EFFECT)
end
function c51100236.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local lp=Duel.GetLP(tp)
	if lp<=1 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(lp-1)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e:GetHandler():RegisterEffect(e1)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetValue(lp-1)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e:GetHandler():RegisterEffect(e1)
	Duel.SetLP(tp,1,REASON_EFFECT)
end
function c51100236.egpcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_GRAVE)
end
function c51100236.egpop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() then
		local e0=Effect.CreateEffect(c)
		e0:SetType(EFFECT_TYPE_SINGLE)
		e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e0:SetReset(RESET_EVENT+0x1fe0000)
		e0:SetCode(EFFECT_CHANGE_CODE)
		e0:SetValue(511000237)
		c:RegisterEffect(e0)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetDescription(aux.Stringid(39853199,0))
		e3:SetCategory(CATEGORY_DESTROY)
		e3:SetType(EFFECT_TYPE_QUICK_O)
		e3:SetCode(EVENT_FREE_CHAIN)
		e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCost(c51100236.descost)
		e3:SetTarget(c51100236.destg)
		e3:SetOperation(c51100236.desop)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e3)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_ALWAYS_ATTACK)
		e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e4)
	end
end
function c51100236.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c51100236.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) 
		and not e:GetHandler():IsStatus(STATUS_CHAINING) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c51100236.despop)
	e1:SetReset(RESET_CHAIN)
	e1:SetLabel(Duel.GetCurrentChain())
	Duel.RegisterEffect(e1,tp)
end
function c51100236.despfilter(c,tp)
	return c:GetSummonPlayer()~=tp
end
function c51100236.despop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c51100236.despfilter,nil,tp)
	if g:GetCount()~=1 then return end
	Duel.ChangeTargetCard(e:GetLabel(),g)
end
function c51100236.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and not tc:IsHasEffect(513000065) then
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EFFECT_IMMUNE_EFFECT)
		e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e3:SetValue(c51100236.desfil)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		Duel.BreakEffect()
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c51100236.desfil(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c51100236.tatkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,e:GetHandler()) end
	local g=Duel.SelectReleaseGroup(tp,nil,1,10,e:GetHandler())
	local tc=g:GetFirst()
	local suma=0
	local sumd=0
	while tc do
		suma=suma+tc:GetAttack()
		sumd=sumd+tc:GetDefense()
		tc=g:GetNext()
	end
	e:SetLabel(suma)
	e:GetLabelObject():SetLabel(sumd)
	Duel.Release(g,REASON_COST)
end
function c51100236.tatkop(e,tp,eg,ep,ev,re,r,rp)
	local atk=e:GetLabel()
	local def=e:GetLabelObject():GetLabel()
	local c=e:GetHandler()
	if c:GetFlagEffect(236)>0 then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(atk)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(def)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
end
function c51100236.uncon(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	return bc and bc:IsRelateToBattle()
end
function c51100236.unop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	bc:RegisterFlagEffect(51100236,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
end
function c51100236.valtg(e,c)
	return c:GetFlagEffect(51100236)>0
end
function c51100236.vala(e,c)
	return c==e:GetHandler()
end
function c51100236.dircon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil and Duel.GetAttacker()==e:GetHandler()
end
function c51100236.dirop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	e:GetHandler():RegisterEffect(e1)
end
function c51100236.negcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return a:IsControler(1-tp) and a:IsFaceup() and a:IsAttribute(ATTRIBUTE_DEVINE) and a:IsRace(RACE_DEVINE) 
		and not a:IsCode(10000011) and not a:IsCode(21208154)
end
function c51100236.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
function c51100236.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--[[Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(51100236,7))
	local op=Duel.SelectOption(tp,aux.Stringid(51100236,8),aux.Stringid(51100236,9),aux.Stringid(51100236,10),
		aux.Stringid(51100236,11),aux.Stringid(51100236,12),aux.Stringid(51100236,13))
	if op~=3 then
		if not Duel.GetControl(c,1-tp) then
			if not c:IsImmuneToEffect(e) and c:IsAbleToChangeControler() then
				Duel.Destroy(c,REASON_EFFECT)
			end
		end
	end
	Duel.BreakEffect()]]
	--control
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	e5:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e5)
	if e:GetCode()~=EVENT_SUMMON_SUCCESS then return end
	local g=c:GetMaterial()
	local tc=g:GetFirst()
	local atk=0
	local def=0
	while tc do
		local catk=tc:GetPreviousAttackOnField()
		local cdef=tc:GetPreviousDefenseOnField()
		atk=atk+(catk>=0 and catk or 0)
		def=def+(cdef>=0 and cdef or 0)
		tc=g:GetNext()
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(atk)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_BASE_DEFENSE)
	e2:SetValue(def)
	c:RegisterEffect(e2)
end
function c51100236.redatk(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and a and a:IsControler(1-tp) and Duel.GetAttackTarget() then
		Duel.ChangeAttackTarget(e:GetHandler())
	end
end
--MLD

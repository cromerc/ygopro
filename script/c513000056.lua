--集いし願い
function c513000056.initial_effect(c)
	--Synchro monster, 1 tuner + n or more monsters
	function aux.AddSynchroProcedure(c,f1,f2,ct)
		local code=c:GetOriginalCode()
		local mt=_G["c" .. code]
		if f1 then
			mt.tuner_filter=function(mc) return mc and f1(mc) end
		else
			mt.tuner_filter=function(mc) return true end
		end
		if f2 then
			mt.nontuner_filter=function(mc) return mc and f2(mc) end
		else
			mt.nontuner_filter=function(mc) return true end
		end
		mt.minntct=ct
		mt.maxntct=99
		mt.sync=true
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetRange(LOCATION_EXTRA)
		e1:SetCondition(Auxiliary.SynCondition(f1,f2,ct,99))
		e1:SetTarget(Auxiliary.SynTarget(f1,f2,ct,99))
		e1:SetOperation(Auxiliary.SynOperation(f1,f2,ct,99))
		e1:SetValue(SUMMON_TYPE_SYNCHRO)
		c:RegisterEffect(e1)
	end
	--Synchro monster, 1 tuner + 1 monster
	function Auxiliary.AddSynchroProcedure2(c,f1,f2)
		local code=c:GetOriginalCode()
		local mt=_G["c" .. code]
		if f1 then
			mt.tuner_filter=function(mc) return mc and f1(mc) end
		else
			mt.tuner_filter=function(mc) return true end
		end
		if f2 then
			mt.nontuner_filter=function(mc) return mc and f2(mc) end
		else
			mt.nontuner_filter=function(mc) return true end
		end
		mt.minntct=1
		mt.maxntct=1
		mt.sync=true
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetRange(LOCATION_EXTRA)
		e1:SetCondition(Auxiliary.SynCondition(f1,f2,1,1))
		e1:SetTarget(Auxiliary.SynTarget(f1,f2,1,1))
		e1:SetOperation(Auxiliary.SynOperation(f1,f2,1,1))
		e1:SetValue(SUMMON_TYPE_SYNCHRO)
		c:RegisterEffect(e1)
	end
	
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c513000056.condition)
	e1:SetTarget(c513000056.target)
	e1:SetOperation(c513000056.activate)
	c:RegisterEffect(e1)
	--return
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(13513663,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCost(c513000056.atkcost)
	e2:SetTarget(c513000056.atktg)
	e2:SetOperation(c513000056.atkop)
	c:RegisterEffect(e2)
	--banish
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(123709,1))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetTarget(c513000056.rmtg)
	e3:SetOperation(c513000056.rmop)
	c:RegisterEffect(e3)
end
function c513000056.cfilter(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsAbleToExtraAsCost()
end
function c513000056.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c513000056.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c513000056.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c513000056.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_MZONE,1,nil) 
		and Duel.IsExistingMatchingCard(nil,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
end
function c513000056.atkop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(1-tp,nil,1-tp,0,LOCATION_MZONE,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.CalculateDamage(tc,g:GetFirst())
		end
	end
end

function c513000056.filter(c,e,tp)
	if not c:IsCode(44508094) then return false end
	local code=c:GetOriginalCode()
	local mt=_G["c" .. code]
	local tuner=Duel.GetMatchingGroup(c513000056.matfilter1,tp,LOCATION_GRAVE,0,nil,c)
	local nontuner=Duel.GetMatchingGroup(c513000056.matfilter2,tp,LOCATION_GRAVE,0,nil,c)
	if not c:IsType(TYPE_SYNCHRO) or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,true,false) 
		or not mt.sync then return false end
	if c:IsSetCard(0x301) then
		return nontuner:IsExists(c513000056.lvfilter2,1,nil,c,tuner)
	else
		return tuner:IsExists(c513000056.lvfilter,1,nil,c,nontuner)
	end
end
function c513000056.lvfilter(c,syncard,nontuner)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	local lv=c:GetSynchroLevel(syncard)
	local slv=syncard:GetLevel()
	local nt=nontuner:Filter(Card.IsCanBeSynchroMaterial,nil,syncard,c)
	return mt.minntct and mt.maxntct and nt:CheckWithSumEqual(Card.GetSynchroLevel,slv-lv,mt.minntct,mt.maxntct,syncard)
end
function c513000056.lvfilter2(c,syncard,tuner)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	local lv=c:GetSynchroLevel(syncard)
	local slv=syncard:GetLevel()
	local nt=tuner:Filter(Card.IsCanBeSynchroMaterial,nil,syncard,c)
	return mt.minntct and mt.maxntct and nt:CheckWithSumEqual(Card.GetSynchroLevel,lv+slv,mt.minntct,mt.maxntct,syncard)
end
function c513000056.matfilter1(c,syncard)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	return c:IsType(TYPE_TUNER) and c:IsCanBeSynchroMaterial(syncard) and c:IsAbleToRemove() 
		and mt.tuner_filter and mt.tuner_filter(c)
end
function c513000056.matfilter2(c,syncard)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	return c:IsType(TYPE_MONSTER) and c:IsNotTuner() and c:IsCanBeSynchroMaterial(syncard) and c:IsAbleToRemove()
		and mt.nontuner_filter and mt.nontuner_filter(c)
end
function c513000056.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	if d:IsControler(1-tp) then a,d=d,a end
	if d:IsControler(1-tp) or not d:IsCode(24696097) or d:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)>0 then return false end
	if d==Duel.GetAttackTarget() and d:IsDefensePos() then return false end
	if d:IsAttackPos() and a:IsDefensePos() and a:GetEffectCount(EFFECT_DEFENSE_ATTACK)==1 
		and d:GetAttack()<=a:GetDefense() then return true end
	if d:IsAttackPos() and (a:IsAttackPos() or a:IsHasEffect(EFFECT_DEFENSE_ATTACK)) 
		and d:GetAttack()<=a:GetAttack() then return true end
	if d:IsDefensePos() and a:IsDefensePos() and a:GetEffectCount(EFFECT_DEFENSE_ATTACK)==1 
		and d:GetDefense()<a:GetDefense() then return true end
	if d:IsDefensePos() and (a:IsAttackPos() or a:IsHasEffect(EFFECT_DEFENSE_ATTACK)) 
		and d:GetDefense()<a:GetAttack() then return true end
	return false
end
function c513000056.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c513000056.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c513000056.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c513000056.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
	Duel.BreakEffect()
	local g=Duel.GetMatchingGroup(c513000056.filter,tp,LOCATION_EXTRA,0,nil,e,tp)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=g:Select(tp,1,1,nil):GetFirst()
		local code=tc:GetOriginalCode()
		local mt=_G["c" .. code]
		local tuner=Duel.GetMatchingGroup(c513000056.matfilter1,tp,LOCATION_GRAVE,0,nil,tc)
		local nontuner=Duel.GetMatchingGroup(c513000056.matfilter2,tp,LOCATION_GRAVE,0,nil,tc)
		local mat1
		if tc:IsSetCard(0x301) then
			nontuner=nontuner:Filter(c513000056.lvfilter2,nil,tc,tuner)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
			mat1=nontuner:Select(tp,1,1,nil)
			local tlv=mat1:GetFirst():GetSynchroLevel(tc)
			tuner=tuner:Filter(Card.IsCanBeSynchroMaterial,nil,tc,mat1:GetFirst())
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
			local mat2=tuner:SelectWithSumEqual(tp,Card.GetSynchroLevel,tc:GetLevel()+tlv,mt.minntct,mt.maxntct,tc)
			mat1:Merge(mat2)
		else
			tuner=tuner:Filter(c513000056.lvfilter,nil,tc,nontuner)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
			mat1=tuner:Select(tp,1,1,nil)
			local tlv=mat1:GetFirst():GetSynchroLevel(tc)
			nontuner=nontuner:Filter(Card.IsCanBeSynchroMaterial,nil,tc,mat1:GetFirst())
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
			local mat2=nontuner:SelectWithSumEqual(tp,Card.GetSynchroLevel,tc:GetLevel()-tlv,mt.minntct,mt.maxntct,tc)
			mat1:Merge(mat2)
		end
		tc:SetMaterial(mat1)
		Duel.Remove(mat1,POS_FACEUP,REASON_EFFECT+REASON_MATERIAL+REASON_SYNCHRO)
		Duel.SpecialSummon(tc,SUMMON_TYPE_SYNCHRO,tp,tp,true,false,POS_FACEUP)
		c:SetCardTarget(tc)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetCondition(c513000056.rcon)
		e2:SetValue(c513000056.val)
		tc:RegisterEffect(e2,true)
	end
end
function c513000056.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
function c513000056.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
function c513000056.vfilter(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsRace(RACE_DRAGON)
end
function c513000056.val(e,c)
	local g=Duel.GetMatchingGroup(c513000056.vfilter,c:GetControler(),LOCATION_GRAVE,0,nil)
	return g:GetSum(Card.GetAttack)
end
function c513000056.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=c:GetFirstCardTarget()
	if chk==0 then return tc end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,Group.FromCards(c,tc),2,0,0)
end
function c513000056.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetFirstCardTarget()
	if not c:IsRelateToEffect(e) then return end
	Duel.Remove(Group.FromCards(c,tc),POS_FACEUP,REASON_EFFECT)
end
